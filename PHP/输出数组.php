print_r() 函数用于打印变量，以更容易理解的形式展示。
print_r() 将把数组的指针移到最后边。使用 reset() 可让指针回到开始处。

<?php
$b = array ('m' => 'monkey', 'foo' => 'bar', 'x' => array ('x', 'y', 'z'));
$results = print_r ($b, true); // $results 包含了 print_r 的输出结果
?>

<?php
//DEBUG============
$es = "";
foreach($result_array[0] as $key=>$value) {
    $es = $es."<br>".$key."=>".$value;
}
die($es);
//============DEBUG
?>
