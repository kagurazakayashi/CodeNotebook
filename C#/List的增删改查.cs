List<string> str = new List<string>();
// 添加
str.Add("1");
str.Add("2");
str.Add("3");
// 遍历
for (int i = 0; i < str.Count; i++)
{
    Console.WriteLine(str[i]);
}
// 删除
str.RemoveAt(0); // 按序号删除
str.Remove("2"); // 按名字删除
// 修改
str[0] = "8"; // 按序号修改
// 按名字修改
for (int i = 0; i < str.Count; i++)
{
    if (str[i] == "4") str[i] = "8";
}
//查找值
if (str.Contains("5"))
    Console.WriteLine("找到了“5”！");
    Console.WriteLine("----------------------");
//查找序号
int index = str.IndexOf("5");
Console.WriteLine("“5”在str中的序号是"+index);

// https://blog.csdn.net/weixin_42224118/article/details/95190023

// 转普通数组
str.ToArray()
// 字符串转List
string s = "1, 2, 3";
List<string> list = new List<string>(str.Split(new string[] { ", " }, StringSplitOptions.RemoveEmptyEntries));