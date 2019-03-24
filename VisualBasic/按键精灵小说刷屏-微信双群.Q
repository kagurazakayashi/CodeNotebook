' 窗口在左上角默认大小，有两个固定群，搞列表中第三个和第四个群
Delay 3000
Dim fso, f1, ts, s
Const ForReading = 1
Set fso = CreateObject("Scripting.FileSystemObject")
Set ts = fso.OpenTextFile("D:\w.txt", ForReading)
do until ts.AtEndOfStream
s = ts.ReadLine
If Len(s) > 0 Then
    MoveTo 181, 279
    LeftClick 1
    Delay 500
    SayString s
    Delay 500
    KeyPress "Enter", 1
    Delay 500
    MoveTo 181, 279
    LeftClick 1
    Delay 500
    SayString s
    Delay 500
    KeyPress "Enter", 1
    Delay 500
End If
loop
ts.Close