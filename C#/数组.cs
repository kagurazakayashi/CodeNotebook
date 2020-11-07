// 声明数组
string[] levelArr = new string[4] { "D", "I", "W", "E" };
// 数组长度
levelArr.Length;
// 使用lambda表达式过滤数组中的空字符串
string[] strArray;
strArray = strArray.Where(s=>!string.IsNullOrEmpty(s)).ToArray();