// 1、如何将字符串String转化为整数int
  int i = Integer.parseInt(str);
  int i = Integer.valueOf(my_str).intValue();
   // 注: 字串转成Double, Float, Long的方法大同小异。
// 2、如何将字符串String转化为Integer
   Integer integer=Integer.valueOf(i)
// 3、如何将整数 int 转换成字串 String？
// 答：有三种方法：
  String s = String.valueOf(i);
  String s = Integer.toString(i);
  String s = "" + i;
// 注：Double, Float, Long 转成字串的方法大同小异。
// 4、如何将整数int转化为Integer
  Integer integer=new Integer(i);
// 5、如何将Integer转化为字符串String
   Integer integer=String();
// 6、如何将Integer转化为int
   int num=Integer.intValue();
// 7、如何将String转化为BigDecimal
   BigDecimal d_id=new BigDecimal(str);
