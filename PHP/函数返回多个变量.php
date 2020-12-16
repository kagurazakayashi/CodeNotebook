php 函数里面只能返回一个值:

若想有多个返回值，可以其转为一个数组
如：

<?php
function slfjo($ht) {
    $a = $ht * 8;
    $b = $a * 9;
    return array($a, $b); //  返回一个数组
}
?>

返回一个数组以得到多个返回值：

<?php
function small_numbers() {
    return array(0, 1, 2);
}
list($zero, $one, $two) = small_numbers();
?>