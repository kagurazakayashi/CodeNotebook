<?php
$num = 12345;
$numI = 0;
$numArr = [];
while ($num > 0) {
    $numI = $num % 10;         // 计算每一位上的数字
    array_push($numArr,$numI); // 保存每一位数字
    $num = intval($num / 10);  // 实现位与位之间的遍历
}
echo json_encode($numArr);
?>