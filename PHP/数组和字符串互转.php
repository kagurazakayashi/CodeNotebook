implode 使用一个字符串将数组变成字符串

<?php
 
$array = array('lastname', 'email', 'phone');
$comma_separated = implode(",", $array);
 
echo $comma_separated; // lastname,email,phone
 
// Empty string when using an empty array:
var_dump(implode('hello', array())); // string(0) ""
 
?>

explode — 使用一个字符串分割另一个字符串，返回一个数组

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