<?php
echo strcmp("Hello","Hello"); //0
echo strcmp("Hello","hELLo"); //1
echo strcmp("Hello world!","Hello world!"); //0 两字符串相等
echo strcmp("Hello world!","Hello"); //7 string1 大于 string2
echo strcmp("Hello world!","Hello world! Hello!"); //-7 string1 小于 string2

$a = '3306.'; //多个点
$b = '3306';
if ($a == $b) echo "相等";

$result="fail";
if (strcmp($result,"success") == 0) {
    //相等
    echo("success");
} else {
    //不相等
    echo("fail");
}
?>