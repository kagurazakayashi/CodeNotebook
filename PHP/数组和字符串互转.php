数组转字符串：

<?php 
// 将一维数组以！分隔组合成一个字符串，参数一可以为""
$str = implode('!', $arr);
?>

字符串转数组：

<?php
// 将字符串以!分割为一个一维数组,参数一不可以为""
$arr = explode('!', $str);
// 将字符串分割成数组，参数二将字符串从左向右每3个字符分割一次，最后的不够3个了 有几个算几个。
$arr = str_split($str, 3);
// 拆成一个个字符的数组
$arr = str_split($str)
?>

implode 数组 → 字符串

<?php
 
$array = array('lastname', 'email', 'phone');
$comma_separated = implode(",", $array);
 
echo $comma_separated; // lastname,email,phone

// Empty string when using an empty array:
var_dump(implode('hello', array())); // string(0) ""
 
?>

explode — 字符串 → 数组

<?php
// 示例 1
$pizza  = "piece1 piece2 piece3 piece4 piece5 piece6";
$pieces = explode(" ", $pizza);
echo $pieces[0]; // piece1
echo $pieces[1]; // piece2

// 示例 2
$data = "foo:*:1023:1000::/home/foo:/bin/sh";
list($user, $pass, $uid, $gid, $gecos, $home, $shell) = explode(":", $data);
echo $user; // foo
echo $pass; // *
?>

str_split — 将字符串按位数转换为数组

<?php

$str = "Hello Friend";

$arr1 = str_split($str); //每个字符
$arr2 = str_split($str, 3); //每3个字符

print_r($arr1);
print_r($arr2);

?>

没有规律的数组转化为字符串

<?php
function substr_cut($katakana){
    $i_end = 1; //打断位数长度，分清楚英文和中文
    $check_sucess = array();
    for($i_start=0; $i_start < strlen($katakana); $i_start=$i_start+1){       
        $str_cut = substr($katakana,$i_start,$i_end);
        $check_sucess[$i_start] = $str_cut;
        echo '$str_cut='.$str_cut.'<br>';
    }
    return $check_sucess;
}
?>