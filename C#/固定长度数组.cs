// 固定长度数组
using System;

class Program
{
    static void Main()
    {
        int a = 10; // 定义数组长度
        string[] stringArray = new string[a]; // 创建固定长度数组

        // 初始化数组
        for (int i = 0; i < a; i++)
        {
            stringArray[i] = $"Element {i + 1}";
        }

        // 输出数组
        foreach (var item in stringArray)
        {
            Console.WriteLine(item);
            /*
            Element 1
            Element 2
            Element 3
            ...
            Element 10
            */
        }
    }
}
