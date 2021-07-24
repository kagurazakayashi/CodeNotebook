// str.indexOf(searchValue, fromIndex)
// 返回指定字符串在原始字符串中第一次出现的的位置（索引值）；
var str = '123456789'
// 返回字符串中 第一个 6 的位置（索引值），从第 5 个字符开始检索
var index = str.indexOf('6', 4)
console.log(index) // 5


// str.lastIndexOf(searchValue, fromIndex)
// 功能同 indexOf() ，查找方向为从右往左查找
var str = '123456789'
// 从右往左查找，返回字符串中 第一个 6 的位置（索引值），从第 8 个字符开始向左检索
var index = str.lastIndexOf('6', 7)
console.log(index) // 5