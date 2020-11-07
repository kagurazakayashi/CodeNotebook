// C#路径中获取文件全路径、目录、扩展名、文件名称
// 常用函数 需要引用 System.IO 直接可以调用Path的静态方法
class Program
{
    static void Main(string[] args)
    {

        //获取当前运行程序的目录
        string fileDir = Environment.CurrentDirectory;
        Console.WriteLine("当前程序目录："+fileDir);

        //一个文件目录
        string filePath = "C:\\JiYF\\BenXH\\BenXHCMS.xml";
        Console.WriteLine("该文件的目录："+filePath);

        string str = "获取文件的全路径：" + Path.GetFullPath(filePath);   //-->C:\JiYF\BenXH\BenXHCMS.xml
        Console.WriteLine(str);
        str = "获取文件所在的目录：" + Path.GetDirectoryName(filePath); //-->C:\JiYF\BenXH
        Console.WriteLine(str);
        str = "获取文件的名称含有后缀：" + Path.GetFileName(filePath);  //-->BenXHCMS.xml
        Console.WriteLine(str);
        str = "获取文件的名称没有后缀：" + Path.GetFileNameWithoutExtension(filePath); //-->BenXHCMS
        Console.WriteLine(str);
        str = "获取路径的后缀扩展名称：" + Path.GetExtension(filePath); //-->.xml
        Console.WriteLine(str);
        str = "获取路径的根目录：" + Path.GetPathRoot(filePath); //-->C:\
        Console.WriteLine(str);
        Console.ReadKey();
    }
}
// https://www.cnblogs.com/JiYF/p/6879139.html