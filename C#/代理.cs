using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace @delegate
{
    delegate void pDelegate(string str, int index);    //声明代理

    class Program
    {
        public static void Show(string str, int index)     //声明方法
        {
            Console.WriteLine("=============== Show" + str + index.ToString());
        }

        static void Main(string[] args)
        {
            pDelegate md = new pDelegate(Show); //1.实例化代理，传入方法
            md("hello world", 22);              //2.传入参数
        }
    }
}
