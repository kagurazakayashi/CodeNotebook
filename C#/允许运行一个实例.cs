// 一、使用用互斥量(System.Threading.Mutex)
// 同步基元，它只向一个线程授予对共享资源的独占访问权。在程序启动时候，请求一个互斥体，如果能获取对指定互斥的访问权，就职运行一个实例。
bool createNew;
using (System.Threading.Mutex mutex = new System.Threading.Mutex(true, Application.ProductName, out createNew))
{
    if (createNew)
    {
        Application.Run(new Form1());
    }
    else
    {
        MessageBox.Show("应用程序已经在运行中...");
        System.Threading.Thread.Sleep(1000);
        System.Environment.Exit(1);
    }
}

// 二、使用进程名
Process[] processes = System.Diagnostics.Process.GetProcessesByName(Application.CompanyName);
if (processes.Length > 1)
{
    MessageBox.Show("应用程序已经在运行中。。");
    Thread.Sleep(1000);
    System.Environment.Exit(1);
}
else
{
    Application.Run(new Form1());
}

// 三、调用Win32 API，并激活并程序的窗口，显示在最前端
/// 该函数设置由不同线程产生的窗口的显示状态
/// </summary> 
/// <param name="hWnd">窗口句柄</param> /// <param name="cmdShow">指定窗口如何显示。查看允许值列表，请查阅ShowWlndow函数的说明部分</param> 
/// <returns>如果函数原来可见，返回值为非零；如果函数原来被隐藏，返回值为零</returns>
[DllImport("User32.dll")]
private static extern bool ShowWindowAsync(IntPtr hWnd, int cmdShow);
/// <summary> 
///  该函数将创建指定窗口的线程设置到前台，并且激活该窗口。键盘输入转向该窗口，并为用户改各种可视的记号。
///  系统给创建前台窗口的线程分配的权限稍高于其他线程。 
/// </summary> 
/// <param name="hWnd">将被激活并被调入前台的窗口句柄</param> 
/// <returns>如果窗口设入了前台，返回值为非零；如果窗口未被设入前台，返回值为零</returns>          
[DllImport("User32.dll")]
private static extern bool SetForegroundWindow(IntPtr hWnd);
private const int SW_SHOWNOMAL = 1;
private static void HandleRunningInstance(Process instance)
{
    ShowWindowAsync(instance.MainWindowHandle, SW_SHOWNOMAL);//显示            
    SetForegroundWindow(instance.MainWindowHandle);//当到最前端          }

private static Process RuningInstance()
{
    Process currentProcess = Process.GetCurrentProcess();
    Process[] Processes = Process.GetProcessesByName(currentProcess.ProcessName);
    foreach (Process process in Processes)
    {
        if (process.Id != currentProcess.Id)
        {
            if (Assembly.GetExecutingAssembly().Location.Replace("/", "\\") == currentProcess.MainModule.FileName)
            {
                return process;
            }
        }
    }
    return null;
}
Process process = RuningInstance();
if (process == null)
{
    Application.Run(new Form1());
}
else
{
    MessageBox.Show("应用程序已经在运行中。。。");

    HandleRunningInstance(process);
    //System.Threading.Thread.Sleep(1000);
    //System.Environment.Exit(1);
}

// https://www.jianshu.com/p/71f1abda9ef7