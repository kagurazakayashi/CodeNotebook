<?php
echo substr("Hello world",6); //world
?>

substr(string,start,length)

string	必需。规定要返回其中一部分的字符串。

start	必需。规定在字符串的何处开始。
正数 - 在字符串的指定位置开始
负数 - 在从字符串结尾开始的指定位置开始
0 - 在字符串中的第一个字符处开始

length	可选。规定被返回字符串的长度。默认是直到字符串的结尾。
正数 - 从 start 参数所在的位置返回的长度
负数 - 从字符串末端返回的长度

<?php
echo substr("Hello world",10); //d
echo substr("Hello world",1); //ello world
echo substr("Hello world",3); //lo world
echo substr("Hello world",7); //orld

echo substr("Hello world",-1); //d
echo substr("Hello world",-10); //ello world
echo substr("Hello world",-8); //lo world
echo substr("Hello world",-4); //orld
?>

<?php
echo substr("Hello world",0,10); //Hello worl
echo substr("Hello world",1,8); //ello wor
echo substr("Hello world",0,5); //Hello
echo substr("Hello world",6,6); //world

echo substr("Hello world",0,-1); //Hello worl
echo substr("Hello world",-10,-2); //ello wor
echo substr("Hello world",0,-6); //Hello
echo substr("Hello world",-2-3); //world
?>