需要获度取当前时间的时间戳：
<?php
$time = date("Y-m-d H:i:s",time());
// 获取当前时间的时间戳函数，使用这个回函数之前注意时区的设置
?>

或者设置成字符串：
<?php
$time = date("Y-m-d H:i:s",time());
// 这里的time()函数其实是可以省略的，建议写上答
?>