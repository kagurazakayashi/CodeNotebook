foreach:

<?php
foreach (array as $value)
  statement();
// 或者：
foreach (array as $key => $value)
  statement();
?>

遍历多维数组:

<?php
$arr_age = array("wang"=>18, "li"=>20, "zhang"=>array("name"=>"小张", "age"=>25));
foreach ($arr_age as $age) {
  if(is_array($age)){
    foreach ( $age as $detail) {
    echo $detail,'<br />';
    }
  } else {
    echo $age,'<br />';
  }
}
?>

PHP 数组是通过哈希表(HashTable)表实现的，因此 foreach 遍历数组时是依据元素添加的先后顺序来进行的。如果想按照索引大小遍历，应该使用 for() 循环遍历。

<?php
$arr_age = array(18, 20, 25);
$num = count($arr_age);
for($i = 0; $i < $num; $i++){
  echo $arr_age[$i]."<br />";
}
?>

也可以用 list() 和 each() 结合来遍历数组，但测试发现效率不如 foreach() 。
