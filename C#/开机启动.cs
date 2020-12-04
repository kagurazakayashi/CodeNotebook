RegistryKey key = Registry.LocalMachine.OpenSubKey("SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run", true);//打开注册表项

if (key == null)//如果该项不存在的话，则创建该项
{
    key = Registry.LocalMachine.CreateSubKey("SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run");
}

key.SetValue(exeName, path);//设置为开机启动

key.DeleteValue(exeName);//取消开机启动
key.Close();

// https://blog.csdn.net/lance_lot1/article/details/8202793