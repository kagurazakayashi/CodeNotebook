// 转数组

string[] strs=str.Split('-');

string menuclassids = string.Join(",", cid_arr);

// 转数字

// c#中不仅仅存在数值类型的数据之间的转换，字符串和数值之间也是可以互相转换的，只是方法不同而已。

// 1 数值型转换为字符型

// 数值型数据转换为字符串用ToString()方法即可实现

int num1=10
string mynum=num1.ToString();

// 2 字符串转换为数值型

// 字符串数据转换为数值型使用Pares()方法
// 字符串转换为整型用int.Pares()

string str="13";
int number=int.Pares(str);
// 字符串转换为双精度浮点型  double.Pares()string

string str="14";
double number =double.Pares(str);

// 字符串转换为单精度浮点型  float.Parse(string)

string str="15";
float number=float.Pares(str);

// 不是认识字符串都可以转换为数值型数据，只有能够表示成数字的字符串才可以进行转换，例如名字“张三”，转换成数字没有可以符合的表达式，就不能实现转换。

// 注意    Pares() 括号中的参数只能是字符串，不能为其他数据类型。
