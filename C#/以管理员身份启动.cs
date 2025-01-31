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
using System.Security.Principal;
using System.Windows.Forms;

namespace AdminCheckRestart
{
    class Program
    {
        [STAThread]
        static void Main(string[] args)
        {
            if (!IsRunAsAdministrator())
            {
                // 重新以管理员身份启动
                RestartAsAdministrator();
                return;
            }

            // 在此执行正常的程序逻辑
            MessageBox.Show("当前以管理员身份运行！", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        /// <summary>
        /// 判断当前是否以管理员权限运行
        /// </summary>
        /// <returns>是否以管理员权限运行</returns>
        static bool IsRunAsAdministrator()
        {
            try
            {
                WindowsIdentity identity = WindowsIdentity.GetCurrent();
                WindowsPrincipal principal = new WindowsPrincipal(identity);
                return principal.IsInRole(WindowsBuiltInRole.Administrator);
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// 重新以管理员身份启动自身
        /// </summary>
        static void RestartAsAdministrator()
        {
            try
            {
                ProcessStartInfo processInfo = new ProcessStartInfo
                {
                    FileName = Application.ExecutablePath,
                    UseShellExecute = true,
                    Verb = "runas" // 指定以管理员权限运行
                };

                Process.Start(processInfo);
            }
            catch (Exception ex)
            {
                MessageBox.Show("无法以管理员权限重新启动应用程序。\n\n错误信息：" + ex.Message, "错误", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}
