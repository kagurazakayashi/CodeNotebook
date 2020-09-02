<?php

define('MIN_VALUE', '0.0');   // 在类定义之外工作。
define('MAX_VALUE', '1.0');   // 在类定义之外工作。

//const MIN_VALUE = 0.0;         在类定义内部和外部工作。
//const MAX_VALUE = 1.0;         在类定义内部和外部工作。

class Constants {
    //define('MIN_VALUE', '0.0');  错误写法 - 在类定义之外的工作。
    //define('MAX_VALUE', '1.0');  错误写法 - 在类定义之外的工作。

    const MIN_VALUE = 0.0;      // 在类定义内部工作。
    const MAX_VALUE = 1.0;      // 在类定义内部工作。

    public static function getMinValue() {
        return self::MIN_VALUE;
    }

    public static function getMaxValue() {
        return self::MAX_VALUE;
    }
}

define('ANIMALS', [
    'dog',
    'cat',
    'bird'
]);

echo ANIMALS[1]; // 输出 "cat"

?>