PHP array_push() 函数

向数组尾部插入 "blue" 和 "yellow"：

<?php
$a=array("red","green");
array_push($a,"blue","yellow");
print_r($a);
?>

带有字符串键名的数组：

<?php
$a=array("a"=>"red","b"=>"green");
array_push($a,"blue","yellow");
print_r($a);
?>

定义和用法
array_push() 函数向第一个参数的数组尾部添加一个或多个元素（入栈），然后返回新数组的长度。

该函数等于多次调用 $array[] = $value。

提示和注释
注释：即使数组中有字符串键名，您添加的元素也始终是数字键。（参见例子 2）

注释：如果用 array_push() 来给数组增加一个单元，还不如用 $array[] =，因为这样没有调用函数的额外负担。

注释：如果第一个参数不是数组，array_push() 将发出一条警告。这和 $var[] 的行为不同，后者会新建一个数组。

语法
array_push(array,value1,value2...)
参数	描述
array	必需。规定数组。
value1	必需。规定要添加的值。
value2	可选。规定要添加的值。
