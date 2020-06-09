String str = "asdfghjkl";

// 方法一
String str = "asdfghjkl";
for(int i=0;i<str.length();i++){
char ch = str.charAt(i);
}


// 方法二
char[] c=s.toCharArray();
for(char cc:c){
  ...//cc直接用了
}

// 方法三
for(int i=0;i<str.length();i++){
  String subStr = str.substring(i, i+1)

// 补充subStr

// str＝str.substring(int beginIndex);截取掉str从首字母起长度为beginIndex的字符串，将剩余字符串赋值给str；

// str＝str.substring(int beginIndex，int endIndex);截取str中从beginIndex开始至endIndex结束时的字符串，并将其赋值给str;这是一个很常见的函数，他的所用

// trim()是去掉字符序列左边和右边的空格，如字符串
// str = "   ai lafu yo   ";
// str = trim(str);
// 输出的将是"ai lafu yo"

// https://blog.csdn.net/qq_38749759/java/article/details/78945552