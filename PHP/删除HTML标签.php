方法1：
直接取出想要取出的标记

<?php
    //取出br标记
    function strip($str)
{
$str=str_replace("<br>","",$str);
//$str=htmlspecialchars($str);
return strip_tags($str);
}
?>

方法2.
PHP 中有个 strip_tags 函数可以方便地去除 HTML 标签。
<?php echo strip_tags("Hello <b>World</b>"); // 去除 HTML、XML 以及 PHP 的标签。 ?>
对于非标准的 HTML 代码也能正确的去除：
<?php echo strip_tags("<a href=\">\">cftea</a>"); //输出 cftea ?>
在PHP中可以使用strip_tags函数去除HTML标签，看下面示例：

<?php
$str = 'www<p>dreamdu</p>.com';
echo(htmlspecialchars($str)."<br>");
echo(strip_tags($str));
?>

方法3.
strtr() 函数转换字符串中特定的字符。
语法
strtr(string,from,to)
或者
strtr(string,array)

参数	描述
string1	必需。规定要转换的字符串。
from	必需（除非使用数组）。规定要改变的字符。
to	必需（除非使用数组）。规定要改变为的字符。
array	必需（除非使用 from 和 to）。一个数组，其中的键是原始字符，值是目标字符。

例子1：

<?php
echo strtr("Hilla Warld","ia","eo");
?>

例子2：

<?php
$arr = array("Hello" => "Hi", "world" => "earth");
echo strtr("Hello world",$arr);
?>
