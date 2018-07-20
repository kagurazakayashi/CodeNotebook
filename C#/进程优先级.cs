using System;
using System.Diagnostics;
 
namespace ConsoleApplication6
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.ReadKey();
            Process.GetCurrentProcess().PriorityClass = ProcessPriorityClass.High;
 
            Console.ReadKey();
            Process.GetCurrentProcess().PriorityClass = ProcessPriorityClass.RealTime;
 
            Console.ReadKey();
        }
    }
}



Process p = new Process();
            p.StartInfo.FileName = @"E:\ForStudy\Project\WindowsApplication1\WindowsApplication1\bin\Debug\WindowsApplication1.exe";
            p.Start();
            p.PriorityClass = ProcessPriorityClass.Idle;
             
            MessageBox.Show(p.BasePriority.ToString());
