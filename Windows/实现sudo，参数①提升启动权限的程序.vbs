'ShellExecute ����
 
'����: ��������һ�������ű���
 
'�﷨
'      .ShellExecute "application", "parameters", "dir", "verb", window
'      .ShellExecute 'some program.exe', '"some parameters with spaces"', , "runas", 1
 
'�ؼ���
'   application   Ҫ���еĳ����ű�����
'   parameters    ���г����ű�����Ĳ���
'   dir           ����·������δָ����ʹ�õ�ǰ·��
'   verb          Ҫִ�еĶ��� (ֵ������ runas/open/edit/print)
'                   runas ����ͨ����������Ȩ��
'   window        �����ű�ִ��ʱ�Ĵ�����ʽ (normal=1, hide=0, 2=Min, 3=max, 4=restore, 5=current, 7=min/inactive, 10=default)
 
 
Set UAC = CreateObject("Shell.Application")
Set Shell = CreateObject("WScript.Shell")
If WScript.Arguments.count<1 Then
    WScript.echo "use: sudo <command> [args]"
ElseIf WScript.Arguments.count=1 Then
    UAC.ShellExecute WScript.arguments(0), "", "", "runas", 1
'    WScript.Sleep 1500
'    Dim ret
'    ret = Shell.Appactivate("�û��˻�����")
'    If ret = true Then
'        Shell.sendkeys "%y"        
'    Else
'        WScript.echo "�Զ���ȡ����ԱȨ��ʧ�ܣ����ֶ�ȷ�ϡ�"
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