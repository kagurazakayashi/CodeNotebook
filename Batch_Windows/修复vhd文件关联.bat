TITLE 修复vhd文件关联

ECHO 这一步会让系统知道：.vhd 和 .vhdx 是一种叫做 Windows.VhdFile 的文件。
assoc .vhd=Windows.VhdFile
assoc .vhdx=Windows.VhdFile

ECHO 告诉系统：“遇到 Windows.VhdFile 类型的文件，用 Mount.exe 打开。”
ftype Windows.VhdFile="%SystemRoot%\System32\Mount.exe" "%1"

ECHO 验证是否成功
assoc .vhd
assoc .vhdx
ftype Windows.VhdFile
@REM 你应该能看到输出：
@REM .vhd=Windows.VhdFile
@REM .vhdx=Windows.VhdFile
@REM Windows.VhdFile="C:\Windows\System32\Mount.exe" "%1"
