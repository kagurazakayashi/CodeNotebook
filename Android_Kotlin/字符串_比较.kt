var str1 = "aaa" // = 是赋值
var str2 = "bbb"

var flag1: Boolean = str1 == str2 // == 是比较，等同于 Java中的 equals()

// equals: true--忽略大小写，false--不忽略大小写。
var flag2: Boolean = str1.equals(str2, true)
// equals(,) 中第二个参数为 true时 效果等价于Java中的 equalsIgnoreCase()