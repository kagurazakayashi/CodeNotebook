@REM 把如下代码保存为批处理“start_setup.bat”，并放到ISO的根目录下+断网！以管理员身份运行。

@echo off
title 安装Win11绕过硬件检测By知彼而知己
echo.
reg query HKU\S-1-5-19 1>nul 2>nul || goto :Admin
echo 正在启动......
@REM 删除(或替换/重命名)appraiserres.dll
del /f /q "%~dp0sources\appraiserres.dll"
@REM 修改5项注册表
@REM 绕过TPM检测
reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassTPMCheck" /t REG_DWORD /d "1" /f
@REM 绕过安全启动检测
reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassSecureBootCheck" /t REG_DWORD /d "1" /f
@REM 绕过内存检测
reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassRAMCheck" /t REG_DWORD /d "1" /f
@REM 绕过硬盘检测
reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassStorageCheck" /t REG_DWORD /d "1" /f
@REM 这一条是微软官方发布的解决方案。主要是绕过CPU检测。且这一项只能绕过TPM2.0，不能绕过TPM1.2（最低要求），也就是说没有TPM模块的来说，绕不过去。
reg add "HKLM\SYSTEM\Setup\MoSetup" /v "AllowUpgradesWithUnsupportedTPMOrCPU" /t REG_DWORD /d "1" /f
reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion\WinPE" || (reg query "HKLM\SYSTEM\CurrentControlSet\Control" /v SystemStartOptions | find /i "MINNT" || (start "11" "%~dp0setup.exe" &exit))
start "11" "%~dp0sources\setup.exe"
exit
@REM 1、Windows下，双击iso\setup.exe时，务必删除appraiserres.dll（或替换或改名）。
@REM 2、Windows下，双击iso\source\setup.exe时，务必保证已修改5项注册表。
@REM 3、WinPE下，无论双击哪个setup.exe，务必保证已修改5项注册表。
:Admin
echo 请以管理员身份运行
echo.
pause >nul