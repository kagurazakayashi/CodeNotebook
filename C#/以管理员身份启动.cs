/*
项目 -> 新建项 -> Application Manifest File （应用程序清单文件）
在 manifest 文件中，找到 requestedExecutionLevel 节点，它的 level 可以设置为如下三种。

<requestedExecutionLevel  level="asInvoker" uiAccess="false" />
<requestedExecutionLevel  level="requireAdministrator" uiAccess="false" />
<requestedExecutionLevel  level="highestAvailable" uiAccess="false" />

如果要用管理员模式的话，使用 requireAdministrator 即可。

代码实现：
*/

using System;
using System.Diagnostics;
using System.Reflection;
using System.Security.Principal;

public static class AdminRelauncher
{
    public static void RelaunchIfNotAdmin()
    {
        if (!RunningAsAdmin())
        {
            Console.WriteLine("Running as admin required!");
            ProcessStartInfo proc = new ProcessStartInfo();
            proc.UseShellExecute = true;
            proc.WorkingDirectory = Environment.CurrentDirectory;
            proc.FileName = Assembly.GetEntryAssembly().CodeBase;
            proc.Verb = "runas";
            try
            {
                Process.Start (proc);
                Environment.Exit(0);
            }
            catch (Exception ex)
            {
                Console
                    .WriteLine("This program must be run as an administrator! \n\n" +
                    ex.ToString());
                Environment.Exit(0);
            }
        }
    }

    private static bool RunningAsAdmin()
    {
        WindowsIdentity id = WindowsIdentity.GetCurrent();
        WindowsPrincipal principal = new WindowsPrincipal(id);
        return principal.IsInRole(WindowsBuiltInRole.Administrator);
    }
}

// https://blog.51cto.com/u_15383815/4676692
