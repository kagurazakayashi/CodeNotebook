TITLE IDM安装报RUNDLL32错误
ECHO Windows 找不到文件 'C:\Users\yashi\WINDOWS\Sysnative\RUNDLL32.EXE'。请确定文件名是否正确后，再试一次。
MKDIR "C:\Users\yashi\WINDOWS"
MKLINK /D "C:\Users\yashi\WINDOWS\Sysnative" "C:\Windows\System32"
