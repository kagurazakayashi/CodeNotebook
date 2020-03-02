// 比对内容： equals
// 比对指针： ==

String s3 = new String("String");
String s4 = new String("String");
System.out.println(s3 == s4); //false
System.out.println(s3.equals(s4)); //true