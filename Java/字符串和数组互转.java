// 1、如果是有分隔符的那种例如"a,b,c";就直接分割
String string = "a,b,c";
String [] stringArr= string.split(",");  //注意分隔符是需要转译
// 2、如果是"abc"这种字符串,就直接
String string = "abc" ;
char [] stringArr = string.toCharArray(); //注意返回值是char数组
// 3、如果要返回byte数组就直接使用getBytes
String string = "abc" ;
byte [] stringArr = string.getBytes();

// https://blog.csdn.net/androidlinuxg/article/details/15339747