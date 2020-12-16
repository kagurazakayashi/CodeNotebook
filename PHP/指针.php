PHP中的变量名称以$开头，因此$ entryId是变量的名称。$ this是PHP中面向对象编程中的一个特殊变量，它引用当前对象。->用于访问PHP中的对象成员（如属性或方法），如C ++中的语法。因此您的代码意味着：

将变量$ entryId的值放入此对象的entryId字段（或属性）中。

PHP中的＆运算符表示传递引用。 这是一个例子：

<?php

$b=2;
$a=$b;
$a=3;
print $a;
print $b;
// output is 32

$b=2;
$a=&$b; // note the & operator
$a=3;
print $a;
print $b;
// output is 33

?>

在上面的代码中，因为我们使用了＆运算符，所以将$ b指向的引用存储在$ a中。 因此，$ a实际上是对$ b的引用。

在PHP中，默认情况下按值传递参数（受C启发）。 因此，在调用函数时，当您传入值时，它们是按值而不是按引用复制的。 这是默认的“大多数情况”。 但是，在定义函数时，有一种方法可以通过引用行为进行传递。 例：

<?php

function plus_by_reference( &$param ) {
    // what ever you do, will affect the actual parameter outside the function
    $param++;
}

$a=2;
plus_by_reference( $a );
echo $a;
// output is 3

?>

有许多内置函数的行为如下。 就像对数组进行排序的sort（）函数一样，该函数将直接影响该数组，并且不会返回另一个已排序的数组。

有一些有趣的事情要注意。 因为按值传递模式可能会导致更多的内存使用，并且PHP是一种解释型语言（因此，用PHP编写的程序不如已编译的程序快），所以要使代码运行更快并最大程度地减少内存使用量，需要进行一些调整。 在PHP解释器中。 一种是惰性复制（我不确定名称）。 这意味着：

当您将一个变量复制到另一个变量时，PHP会将对第一个变量的引用复制到第二个变量中。 因此，到目前为止，您的新变量实际上是对第一个变量的引用。 该值尚未复制。 但是，如果您尝试更改这些变量中的任何一个，PHP将复制该值，然后更改该变量。 这样，如果您不更改值，则将有机会节省内存和时间。

所以：

<?php
$b=3;
$a=$b;
// $a points to $b, equals to $a=&$b
$b=4;
// now PHP will copy 3 into $a, and places 4 into $b
?>

毕竟，如果要将$ entryId的值放入对象的'entryId'属性中，上述代码将执行此操作，并且不会复制entryId的值，除非您更改其中的任何一个，否则将导致内存减少 用法。 如果您实际上希望它们都指向相同的值，请使用以下命令：

<?php $this->entryId=&$entryId; ?>

合并使用：任意数量指针输入，遍历和类型转换自增：

<?php
/**
 * @description: 将多个字符串变量转换为整数并增加数值
 * @param Int add 要进行加法的数字
 * @param String *numString 要进行转换并运算的多个字符串
 */
function intStringAdd(int $add = 1, string &...$numString): void {
    foreach ($numString as &$nowVal) {
        $nowVal = intval($nowVal) + $add;
    }
}

$a = "1";
$b = "2";
$c = "3";

intStringAdd(1, $a, $b, $c);

var_dump($a, $b, $c); // int(2) int(3) int(4)
?>