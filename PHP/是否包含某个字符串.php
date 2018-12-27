<?php
if (strpos('www.aaabbb.com','aaabbb') !== false) {
    echo '包含';
} else {
    echo '不包含';
}
?>

strpos() 函数返回字符串在另一个字符串中第一次出现的位置。
如果没有找到该字符串，则返回 false。
string 必需。规定被搜索的字符串。
find 必需。规定要查找的字符。
start 可选。规定开始搜索的位置。
该函数对大小写敏感。如需进行对大小写不敏感的搜索，请使用 stripos()函数。

<?php
　　echo strpos(www.aaabbb.com,"aaa");
?>
输出：4
