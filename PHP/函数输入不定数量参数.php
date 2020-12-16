例子1: 使用…$args代替任意数量参数

<?php

function myfunc(...$args){

    // 获取参数数量
    echo count($args).PHP_EOL;

    // 获取第一个参数的值：
    print_r($args[0]);
    echo PHP_EOL;

    // 获取所有参数的值
    print_r($args);
    echo PHP_EOL;

}

myfunc('a');
myfunc(1, 2, 3);
myfunc(array('d','e'), array('f'));

?>

例子2: 数组转为参数列表

<?php

function add($a, $b){
    echo $a + $b;
}

$args = array(1, 2);

add(...$args); // 输出3

?>

例子3: 部分参数指定，其他参数数量不定

<?php

function display($name, $tag, ...$args){
    echo 'name:'.$name.PHP_EOL;
    echo 'tag:'.$tag.PHP_EOL;
    echo 'args:'.PHP_EOL;
    print_r($args);
    echo PHP_EOL;
}

display('fdipzone', 'programmer');
display('terry', 'designer', 1, 2);
display('aoao', 'tester', array('a','b'), array('c'), array('d'));

?>

输出：

name:fdipzone
tag:programmer
args:
Array
(
)

name:terry
tag:designer
args:
Array
(
    [0] => 1
    [1] => 2
)

name:aoao
tag:tester
args:
Array
(
    [0] => Array
        (
            [0] => a
            [1] => b
        )

    [1] => Array
        (
            [0] => c
        )

    [2] => Array
        (
            [0] => d
        )

)


在php5.5及更早的版本中，使用func_num_args(), func_get_arg(), func_get_args()函数实现。

<?php

function oldfunc(){

    // 获取参数数量
    echo func_num_args().PHP_EOL;

    // 获取第一个参数的值：
    print_r(func_get_arg(0));
    echo PHP_EOL;

    // 获取所有参数的值
    print_r(func_get_args());
    echo PHP_EOL;

}

myfunc('a');
myfunc(1, 2, 3);
myfunc(array('d','e'), array('f'));

?>

<!-- https://blog.csdn.net/fdipzone/article/details/70525450 -->