/*
相同点：
　　1. ref 和 out 都是按地址传递的，使用后都将改变原来参数的数值；

　　2. 方法定义和调用方法都必须显式使用 ref 或者 out关键字；

　　3. 通过ref 和 ref 特性,一定程度上解决了C#中的函数只能有一个返回值的问题。

不同点：
　　传递到 ref 参数的参数必须初始化,否则程序会报错。

简单的说

ref 先初始化
out 在方法里初始化

你需要在方法里改变的参数 用ref
你不需要传递数据需要获得多个返回结果的 用out
*/

using System;

class Program
{

    static void Main(string[] args)
    {
        //out在这里赋不赋值没影响
        //int a = 10;
        //int b = 20;
        int a, b;
        GetValue(out a, out b);
        Console.WriteLine($"1: {a}  {b}");
        Console.ReadKey();
    }
    static void GetValue(out int x, out int y)
    {
        //out在方法内必须先赋值再用。
        //Console.WriteLine($"3: "{x}  {y}");
        x = 50;
        y = 60;
        Console.WriteLine($"2: {x}  {y}");
    }

    //输出
    // 2: 50  60
    // 1: 50  60
}