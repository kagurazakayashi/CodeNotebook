stristr() 函数查找字符串在另一个字符串中第一次出现的位置。
如果成功，则返回字符串的其余部分（从匹配点）。如果没有找到该字符串，则返回 false。
它和strstr的使用方法完全一样.唯一的区别是stristr不区分大小写.
<?php
$email = 'user@example.com';
$domain = strstr($email, '@');
echo $domain;
// prints @example.com
?>

strpos函数返回boolean值.FALSE和TRUE不用多说.用 “===”进行判断.strpos在执行速度上都比以上两个函数快,另外strpos有一个参数指定判断的位置,但是默认为空.意思是判断整个字符串.缺点是对中文的支持不好.
<php
if (strpos('abcd','bc') !== false){
    echo '包含bc';
} else {
    echo '不包含bc';
}
？>

