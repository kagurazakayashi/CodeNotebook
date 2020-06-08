PHP Ctype 扩展的函数
<?php

// 是否全部为字母和(或)数字字符？
ctype_alnum($testcase);

// 每个字符都是一个字母？ [A-Za-z]
ctype_alpha($testcase);

// 是不是都是控制字符？
// 控制字符就是例如：换行、缩进、空格。
ctype_cntrl($testcase);

// 是不是都是数字？
ctype_digit($testcase);

// 字符输出都是可见的？
ctype_graph($testcase);

// 是不是都是小写字母？
ctype_lower($testcase);

// 是不是都是可以打印出来？
// 如果 text 里面包含控制字符或者那些根本不会有任何输出的字符串，就返回 FALSE 。
ctype_print($testcase);

// 里面的字符是不是都是标点符号？
// 里面的每个字符都是能打印的，但不是字母、数字，也不是空白，那么就返回 TRUE。
ctype_punct($testcase);

// 里面的字符是否包含空白？
// 除了空白字符，还包括缩进，垂直制表符，换行符，回车和换页字符。
ctype_space($testcase);

// 里面的字符是不是都是大写字母？
ctype_upper($testcase);

// 检测字符串是否只包含十六进制字符
// 也就是只能包含十进制的树枝和 [A-Fa-f] 的字母。
ctype_xdigit($testcase);
?>