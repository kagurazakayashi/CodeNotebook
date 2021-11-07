double price = 100 / 3;

// 舍弃小数部分（取整）

//舍弃当前变量的小数部分，结果为 33。返回值为 int 类型。
price.truncate();
//舍弃当前变量的小数部分，浮点数形式表示，结果为 33.0。返回值为 double。
price.truncateToDouble();
//舍弃当前变量的小数部分，结果为 33。返回值为 int 类型。
price.toInt();
//小数部分向上进位，结果为 34。返回值为 int 类型。
price.ceil();
//小数部分向上进位，结果为 34.0。返回值为 double。
price.ceilToDouble();
//当前变量四舍五入后取整，结果为 33。返回值为 int 类型。
price.round();
//当前变量四舍五入后取整，结果为 33.0。返回值为 double 类型。
price.roundToDouble();

// 保留小数点后 n 位

double price = 100 / 3;
//保留小数点后2位数，并返回字符串：33.33。
price.toStringAsFixed(2);
//保留小数点后5位数，并返回一个字符串 33.33333。
price.toStringAsFixed(5);
// toStringAsFixed() 方法会进行四舍五入。


// https://blog.csdn.net/u011578734/article/details/112251314
