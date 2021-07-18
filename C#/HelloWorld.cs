using System;
/*
 * 引用命名空间
 * C#程序的结构认为
 * 一个程序可以由多个名字空间组成
 * 一个名字空间中可以包括多个类和接口
 */
using System.Collections.Generic;
using System.Text;

namespace CSTEMP //自己的命名空间
{
    class Program
    {
        /*
         * Main() 函数是C#程序的入口，从 Main() 函数开始执行
         * static 静态的
         * public 公共的
         * string[] args 字符串数组， Main() 函数的参数，表示命令行参数
         */
        public static void Main(string[] args)
        {
            // Console 控制台类，终端
            Console.WriteLine("Hello World!");
            Console.Write("Press any key to continue ...");
            // ReadKey() 等待用户按下键
            Console.ReadKey(true);
        }
    }
}