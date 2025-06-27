TITLE 查询谁在占用COM串口

ECHO 资源监视器 - CPU - 关联的句柄 - 搜索 \Device\Serial0

ECHO 使用 handle.exe 工具
ECHO https://learn.microsoft.com/en-us/sysinternals/downloads/handle
ECHO 管理员权限的命令提示符（CMD） 中运行：
handle.exe -a COM1

ECHO 使用 Process Explorer
ECHO https://learn.microsoft.com/en-us/sysinternals/downloads/process-explorer
procexp.exe
ECHO 按 Ctrl + F，搜索关键词 COM1

ECHO PowerShell 列出所有命令提示符连接
Get-WmiObject Win32_SerialPort | Where-Object { $_.DeviceID -eq "COM1" } | Format-List *
Get-Process | Where-Object {
    ($_ | Get-Process).Modules | Where-Object { $_.FileName -like "*serial*" }
}
