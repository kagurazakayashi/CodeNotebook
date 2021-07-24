/*
charAt()      返回字符串中的第 n 个字符
charCodeAt()  返回字符串中的第 n 个字符的代码
indexOf()     检索字符串
lastIndexOf() 从后向前检索一个字符串
match()       找到一个或多个正则表达式的匹配
search()      检索与正则表达式相匹配的子串
*/

// 查找字符串

var s = "JavaScript";
var i = s.indexOf("a");
console.log(i);  //返回值为1，即字符串中第二个字符

var s = "c.biancheng.net";
var a = s.indexOf("biancheng");  //返回值为3，即第一个字符n的下标位置

var s = "c.biancheng.net";
var b = s.indexOf(".");  //返回值为1，即第一个字符.的下标位置
var e = s.indexOf(".", b + 1);  //返回值为11，即第二个字符.的下标位置

var s = "c.biancheng.net";
var n = s.lastIndexOf(".");  //返回值为11，即第二个字符.的下标位置

var s = "http://c.biancheng.net";
var n = s.lastIndexOf(".", 11);  //返回值是8，而不是18

var s = "http://c.biancheng.net";
var n = s.lastIndexOf("c");  //返回值为7

// 搜索字符串

var s = "c.biancheng.net";
n="s.search("//");"

// 匹配字符串

var s = "http://c.biancheng.net";
var a = s.match(/c/n);  //全局匹配所有字符c
console.log(a);  //返回数组[c,c]。

var a = s.match(/c/);  //返回数组[h]

var s = "http://c.biancheng.net";
var a = s.match(/(\.).*(\.).*(\.)/ );  //执行一次匹配检索
console.log(a.length);
console.log(a[0]);
console.log(a[1]);
console.log(a[2]);
console.log(a[3]);

// http://c.biancheng.net/view/5581.html