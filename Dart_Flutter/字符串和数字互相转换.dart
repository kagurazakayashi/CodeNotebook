int num1 = 10;

// int转String
String str = num1.toString();

// String转int
int num2 = int.parse(str);


// 字符串转数字 安全

int myInt = int.parse('12345'); // 转为整型
assert(myInt is int);
print(myInt); // 12345

double myDouble = double.parse('123.45'); // 转为double
assert(myDouble is double);
print(myDouble); // 123.45

//如果字符串不确定是否为数字的话，还可以使用以下方法
int val = int.tryParse(text) ?? defaultValue;
//如果text不是数字则返回defaultValue，从而实现数字的安全转化