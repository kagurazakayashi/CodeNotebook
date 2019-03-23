<?php
$char = '中华民国Abc';
function mbStrSplit($string){
   return preg_split('/(?<!^)(?!$)/u' , $string);
}
print_r(mbStrSplit($char));
?>
