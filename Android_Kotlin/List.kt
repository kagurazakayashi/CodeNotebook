// 声明 List 时主要是通过 listOf() 实现
var list1 = listOf("a", "b", "c")
// 使用 for 循环同时遍历索引和索引对应的数值
for ((index, value) in list1.withIndex()) {
    //重点是 withIndex() 方法，index 接收索引，value 接收对应的值
    //DO STH
}