// 方法一: indexOf() (推荐)
var str = "123";
console.log(str.indexOf("3") >= 0);  // true
// indexOf() 方法可返回某个指定的字符串值在字符串中首次出现的位置。如果要检索的字符串值没有出现，则该方法返回 -1。

// 方法二: search()
var str = "123";
console.log(str.search("3") >= 0);  // true
// search() 方法用于检索字符串中指定的子字符串，或检索与正则表达式相匹配的子字符串。如果没有找到任何匹配的子串，则返回 -1。