// 本机都有哪些用户组

using System;
using System.DirectoryServices;

class Program
{
    static void Main()
    {
        string machineName = Environment.MachineName;

        // 连接到本地计算机的用户组
        DirectoryEntry localMachine = new DirectoryEntry($"WinNT://{machineName},Computer");

        foreach (DirectoryEntry child in localMachine.Children)
        {
            if (child.SchemaClassName == "Group")
            {
                Console.WriteLine(child.Name);
            }
        }
    }
}
