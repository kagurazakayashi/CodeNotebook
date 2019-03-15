'ShellExecute 方法
 
'作用: 用于运行一个程序或脚本。
 
'语法
'      .ShellExecute "application", "parameters", "dir", "verb", window
'      .ShellExecute 'some program.exe', '"some parameters with spaces"', , "runas", 1
 
'关键字
'   application   要运行的程序或脚本名称
'   parameters    运行程序或脚本所需的参数
'   dir           工作路径，若未指定则使用当前路径
'   verb          要执行的动作 (值可以是 runas/open/edit/print)
'                   runas 动作通常用于提升权限
'   window        程序或脚本执行时的窗口样式 (normal=1, hide=0, 2=Min, 3=max, 4=restore, 5=current, 7=min/inactive, 10=default)
 
 
Set UAC = CreateObject("Shell.Application")
Set Shell = CreateObject("WScript.Shell")
If WScript.Arguments.count<1 Then
    WScript.echo "语法:  sudo <command> [args]"
ElseIf WScript.Arguments.count=1 Then
    UAC.ShellExecute WScript.arguments(0), "", "", "runas", 1
'    WScript.Sleep 1500
'    Dim ret
'    ret = Shell.Appactivate("用户账户控制")
'    If ret = true Then
'        Shell.sendkeys "%y"        
'    Else
'        WScript.echo "自动获取管理员权限失败，请手动确认。"
'    End If
Else
    Dim ucCount
    Dim args
    args = NULL
    For ucCount=1 To (WScript.Arguments.count-1) Step 1
        args = args & " " & WScript.Arguments(ucCount)
    Next
    UAC.ShellExecute WScript.arguments(0), args, "", "runas", 5
End If