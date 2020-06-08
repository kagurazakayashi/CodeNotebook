PHP敏感词过滤DFA算法实现
使用PHP借助DFA算法实现敏感词过滤功能，参照了zenghansen的代码，其中修改了原类的BUG，并增加了查找方法，并对王*八&&蛋这样的，中间填充了无意义的字符来混淆的词的增强匹配处理。
DFA敏感词过滤的原理就是将所有的敏感词载中内存，构建一个个树结构，然后将待匹配的字符串截断成数组，匹配每个数组元素与构建的敏感字典树的节点，匹配得到终节点就说明匹配成功。

对应PHP实现代码如下：
<?php

/**
 * 敏感词过滤工具类DFA算法
 *
 * @author zenghansen  http://www.cnblogs.com/zenghansen/p/5688995.html
 */
class SensitiveWordsUtils {

    private $dict;

    public function __construct($words) {
        $this->dict = array();
        // 构建敏感词树
        foreach ($words as $_word) {
            $uWord = $this->unicodeSplit($_word);

            $pdict = &$this->dict;

            $count = count($uWord);
            for ($i = 0; $i < $count; $i++) {
                if (!isset($pdict[$uWord[$i]])) {
                    $pdict[$uWord[$i]] = array();
                }
                $pdict = &$pdict[$uWord[$i]];
            }

            $pdict['end'] = true;
        }
    }

    // 判断是否包含敏感词
    public function contains($str) {
        $uStr = $this->unicodeSplit($str);
        $count = count($uStr);

        for ($i = 0; $i < $count; $i++) {
            $pdict = $this->dict;
            $char = strtolower($uStr[$i]);
            if (isset($pdict[$char])) {
                $pdict = $pdict[$char];
                for ($j = $i + 1; $j < $count; $j++) {
                    $char2 = strtolower($uStr[$j]);
                    if (isset($pdict[$char2])) {
                        if (isset($pdict['end'])) {
                            // 小串匹配，例：宝宝
                            return true;
                        }
                        $pdict = $pdict[$char2];
                    } else if (!preg_match("/[ +=*&$#@\"')(~_]/", $char2)) {
                        // 以特别的字符进行分割敏感词的手段也要匹配
                        // 例：大****麻，匹配：大麻
                        break;
                    }
                }
                if (isset($pdict['end'])) {
                    // 大串匹配，例：宝宝穿越记
                    return true;
                }
            }
        }
        return false;
    }

    // 替换敏感词为*号，搜索深度默认为5
    public function filter($str, $maxDistance = 5) {
        if ($maxDistance < 1) {
            $maxDistance = 1;
        }
        $uStr = $this->unicodeSplit($str, false);

        $count = count($uStr);

        for ($i = 0; $i < $count; $i++) {
            // 每个字符的开始，都是重新从词典开始匹配，做到不放过句子中的任何敏感词
            $pdict = $this->dict;
            $char = strtolower($uStr[$i]);
            if (isset($pdict[$char])) {
                $pdict = $pdict[$char];

                $matchIndexes = array();

                for ($j = $i + 1, $d = 0; $d < $maxDistance && $j < $count; $j++, $d++) {
                    $char2 = strtolower($uStr[$j]);
                    if (isset($pdict[$char2])) {
                        if (isset($pdict['end'])) {
                            // 小串匹配，例：宝宝
                            $uStr[$i] = '*';
                            foreach ($matchIndexes as $k) {
                                if ($k - $i == 1) {
                                    $i = $k;
                                }
                                $uStr[$k] = '*';
                            }
                            $matchIndexes = array();
                        }
                        $matchIndexes[] = $j;
                        $pdict = $pdict[$char2];
                        $d = -1;
                    } else if (!preg_match("/[ +=*&$#@\"')(~_]/", $char2)) {
                        // 以特别的字符进行分割敏感词的手段也要匹配
                        // 例：大****麻，匹配：大麻
                        break;
                    }
                }

                if (isset($pdict['end'])) {
                    // 大串匹配，例：宝宝穿越记
                    $uStr[$i] = '*';
                    foreach ($matchIndexes as $k) {
                        if ($k - $i == 1) {
                            $i = $k;
                        }
                        $uStr[$k] = '*';
                    }
                }
            }
        }

        return implode($uStr);
    }

    // 将字符串分割成数组
    public function unicodeSplit($str, $caseword = true) {
        if ($caseword)
            $str = strtolower($str);
        $ret = array();
        $len = strlen($str);
        for ($i = 0; $i < $len; $i++) {
            $c = ord($str[$i]);

            if ($c & 0x80) {
                if (($c & 0xf8) == 0xf0 && $len - $i >= 4) {
                    if ((ord($str[$i + 1]) & 0xc0) == 0x80 && (ord($str[$i + 2]) & 0xc0) == 0x80 && (ord($str[$i + 3]) & 0xc0) == 0x80) {
                        $uc = substr($str, $i, 4);
                        $ret[] = $uc;
                        $i += 3;
                    }
                } else if (($c & 0xf0) == 0xe0 && $len - $i >= 3) {
                    if ((ord($str[$i + 1]) & 0xc0) == 0x80 && (ord($str[$i + 2]) & 0xc0) == 0x80) {
                        $uc = substr($str, $i, 3);
                        $ret[] = $uc;
                        $i += 2;
                    }
                } else if (($c & 0xe0) == 0xc0 && $len - $i >= 2) {
                    if ((ord($str[$i + 1]) & 0xc0) == 0x80) {
                        $uc = substr($str, $i, 2);
                        $ret[] = $uc;
                        $i += 1;
                    }
                }
            } else {
                $ret[] = $str[$i];
            }
        }

        return $ret;
    }
}
?>

使用示例：
<?php
// 从数据库中加载敏感词数组
function loadWords() {
    $mysql_conf = array(
        'host' => '127.0.0.1:3306',
        'db' => 'test',
        'db_user' => 'root',
        'db_pwd' => '123456',
    );
    $pdo = new PDO("mysql:host=" . $mysql_conf['host'] . ";dbname=" . $mysql_conf['db'], $mysql_conf['db_user'], $mysql_conf['db_pwd']);
    $pdo->exec("set names 'utf8'");
    $sql = "select keyword from dtb_sensitive_words";
    $stmt = $pdo->prepare($sql);
    $rs = $stmt->execute();
    $words = array();
    if ($rs) {
        // PDO::FETCH_ASSOC 关联数组形式
        // PDO::FETCH_NUM 数字索引数组形式
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $words[] = $row['keyword'];
        }
    }
    $pdo = null; //关闭连接
    return $words;
}

$words = loadWords();
$util = new SensitiveWordsUtils($words);

$param = "哪有宝宝穿越，是不是的啊大 三 元哈哈哈----";
echo $param . "\n";
// $param = "宝宝穿越记";
if ($util->contains($param)) {
    echo $util->filter($param, 10);
} else{
    echo "没有敏感词";
}
?>

如下，敏感词有：宝宝、宝宝穿越记、大三元，输出的结果为：

哪有宝宝穿越，是不是的啊大 三 元哈哈哈----
哪有**穿越，是不是的啊* * *哈哈哈----

<!-- https://lzqwebsoft.net/show/20180809045928.html -->