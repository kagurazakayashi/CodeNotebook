string path = "1.txt";

// 使用File.ReadAllText读取文本文件
// File.ReadAllText()方法打开一个文本文件，将文件的所有行读取为字符串，然后关闭文件。
string content = File.ReadAllText(path, Encoding.UTF8);
Console.WriteLine(content);

// 使用File.ReadAllLines读取文本文件
// File.ReadAllLines()打开一个文本文件，将文件的所有行读入字符串数组，然后关闭文件。
string[] lines = File.ReadAllLines(path, Encoding.UTF8);
foreach (string line in lines)
{
    Console.WriteLine(line);
}



using System.IO;

// 使用StreamReader读取文本文件
// StreamReader设计用于以特定编码输入字符。 它用于从标准文本文件中读取信息行。
// ReadToEnd()方法从流的当前位置到其末尾读取所有字符。
using var fs = new FileStream(path, FileMode.Open, FileAccess.Read);
using var sr = new StreamReader(fs, Encoding.UTF8);
string content = sr.ReadToEnd();
Console.WriteLine(content);

// 使用StreamReader的ReadLine
// StreamReader的ReadLine()方法从当前流中读取一行字符，并将数据作为字符串返回。
// 该代码示例逐行读取文件。
FileStream fs = new FileStream(path, FileMode.Open, FileAccess.Read);
StreamReader sr = new StreamReader(fs, Encoding.UTF8);
string line = String.Empty;
while ((line = sr.ReadLine()) != null)
{
    Console.WriteLine(line);
}

// 与StreamReader的ReadToEndAsync异步读取文本文件
// ReadToEndAsync()方法异步读取从当前位置到流末尾的所有字符，并将它们作为一个字符串返回。
using var fs = new FileStream(path, FileMode.Open, FileAccess.Read);
using var sr = new StreamReader(fs, Encoding.UTF8);
string content = await sr.ReadToEndAsync();
Console.WriteLine(content);
