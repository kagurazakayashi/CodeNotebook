Delay 3000
Dim fso, f1, ts, s
Const ForReading = 1
Set fso = CreateObject("Scripting.FileSystemObject")
Set ts = fso.OpenTextFile("D:\w.txt", ForReading)
do until ts.AtEndOfStream
s = ts.ReadLine
If Len(s) > 0 Then
    SayString s
    Delay 500
    KeyPress "Enter", 1
    Delay 1000
End If
loop
ts.Close