Process p = new Process();
p.StartInfo.FileName = "cmd.exe"; //要启动的程序
p.StartInfo.Arguments = ""; //命令行参数
p.StartInfo.WorkingDirectory = ""; //设置工作目录
p.StartInfo.WindowStyle = ProcessWindowStyle.Normal; //窗口模式
p.StartInfo.UseShellExecute = false; //是否使用操作系统外壳程序启动进程
p.StartInfo.RedirectStandardInput = true; //是否获取标准输入
p.StartInfo.RedirectStandardOutput = true; //是否获取标准输出
p.StartInfo.CreateNoWindow = false; //不显示程序窗口
p.Start(); //启动程序
//向CMD窗口发送输入信息：
p.StandardInput.WriteLine("dir");
p.StandardInput.WriteLine("exit");
p.StandardInput.Close(); //结束输入
p.WaitForExit(); //暂停本程序，等待被调用的程序结束。
//获取CMD窗口的输出信息：
string sOutput = p.StandardOutput.ReadToEnd();
p.StandardOutput.Close(); //结束输出
p.Close(); //关闭


// 使用事件：
Process process = new Process();
process.StartInfo.FileName = "cmd.exe"
process.StartInfo.CreateNoWindow = true;
process.StartInfo.ErrorDialog = false;
process.StartInfo.UseShellExecute = false;
process.StartInfo.RedirectStandardError = true;
process.StartInfo.RedirectStandardInput = true;
process.StartInfo.RedirectStandardOutput = true;
process.EnableRaisingEvents = true;
process.OutputDataReceived += process_OutputDataReceived;
process.ErrorDataReceived += process_OutputDataReceived;
process.Exited += process_Exited;
process.Start();
process.BeginErrorReadLine();
process.BeginOutputReadLine();

void process_Exited(object sender, System.EventArgs e)
{
    // 当进程终止时做些什么
}

void process_OutputDataReceived(object sender, DataReceivedEventArgs e)
{
    // 一行写入输出流。你可以这样使用:
    string s = e.Data;
}

void process_ErrorDataReceived(object sender, DataReceivedEventArgs e)
{
    // 一行写入输出流。你可以这样使用:
    string s = e.Data;
}

// https://www.cnblogs.com/Tammie/archive/2011/09/06/2168335.html