@REM 安装 Windows ADK 和 Windows PE 加载项。
D:
SET PEDir=D:\WinPEbitlocker
SET MountDir=%PEDir%\mount
SET ISO=B:\WinPE_BitLocker_SMB.iso

@REM 以管理员身份打开“部署和映像工具环境”，运行以下命令：
copype amd64 %PEDir%

@REM 挂载映像
CD %PEDir%
MKDIR %MountDir%
dism /Mount-Image /ImageFile:%PEDir%\media\sources\boot.wim /index:1 /MountDir:%MountDir%

@REM 添加 BitLocker 支持
dism /Image:%MountDir% /Add-Package /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-WMI.cab"
dism /Image:%MountDir% /Add-Package /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-SecureStartup.cab"

@REM 添加网络与 SMB 支持
dism /Image:%MountDir% /Add-Package /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-NetFx.cab"
dism /Image:%MountDir% /Add-Package /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-Scripting.cab"

@REM PowerShell（可不需要）
dism /Image:%MountDir% /Add-Package /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-PowerShell.cab"

@REM 英文语言包
dism /Image:%MountDir% /Add-Package /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-WMI_en-us.cab"
dism /Image:%MountDir% /Add-Package /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-Scripting_en-us.cab"
dism /Image:%MountDir% /Add-Package /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-SecureStartup_en-us.cab"

@REM 已安装的包
dism /Image:%MountDir% /Get-Packages

@REM 编写启动脚本 (Startup.bat)
notepad "%MountDir%\Windows\System32\Startup.bat"
wpeinit
netsh advfirewall set allprofiles state off
sc config LanmanServer start= auto
net start LanmanServer
TYPE note.txt
cmd.exe

@REM 说明书
notepad "%MountDir%\Windows\System32\note.txt"
==============================
SHUTDOWN:
wpeutil shutdown
wpeutil reboot

BitLocker:
manage-bde -unlock D: -pw
manage-bde -unlock D: -RecoveryPassword

SHARE:
net share D=D:\ /grant:everyone,full
==============================


@REM WinPE 启动后直接运行脚本，而不会加载任何其他界面(一定保存成 ANSI 编码)
notepad "%MountDir%\Windows\System32\Winpeshl.ini"
[LaunchApps]
%SYSTEMROOT%\System32\Startup.bat

@REM WinPE 环境下，由于没有用户账户管理，设置 SMB 共享通常需要允许匿名访问。
@REM 你可以通过在 Startup.bat 中添加以下注册表项来降低安全限制（仅限 PE 环境下临时取回文件使用）：
reg add "HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters" /v "RestrictNullSessAccess" /t REG_DWORD /d 0 /f

@REM 压缩
compact /c /s:"%MountDir%" /i

@REM 调大控制台字符和全屏
@REM 挂载 DEFAULT 配置单元
reg load HKLM\PE_DEFAULT %MountDir%\Windows\System32\config\DEFAULT
@REM 修改控制台字体为点阵字体 (Terminal)
reg add "HKLM\PE_DEFAULT\Console" /v "FaceName" /t REG_SZ /d "Terminal" /f
reg add "HKLM\PE_DEFAULT\Console" /v "FontFamily" /t REG_DWORD /d 0 /f
reg add "HKLM\PE_DEFAULT\Console" /v "FontSize" /t REG_DWORD /d 1179658 /f
reg add "HKLM\PE_DEFAULT\Console" /v "FontWeight" /t REG_DWORD /d 400 /f
@REM 卸载
reg unload HKLM\PE_DEFAULT

CD ..
@REM 保存
dism /Commit-Image /MountDir:"%MountDir%"
@REM 卸载
dism /Unmount-Image /MountDir:"%MountDir%" /Commit
dism /Unmount-Image /MountDir:"%MountDir%" /Discard
RD /S /Q %MountDir%

@REM 生成 ISO 文件
DEL "%ISO%"
MakeWinPEMedia /ISO "%PEDir%" "%ISO%"

@REM 调试一键
dism /Commit-Image /MountDir:"%MountDir%" && DEL "%ISO%" && MakeWinPEMedia /ISO "%PEDir%" "%ISO%"

@REM 压缩映像
dism /Export-Image /SourceImageFile:%PEDir%\media\sources\boot.wim /SourceIndex:1 /DestinationImageFile:B:\boot.wim /Compress:max /CheckIntegrity
DEL %PEDir%\media\sources\boot.wim
MOVE B:\boot.wim %PEDir%\media\sources\boot.wim

@REM 自用启动脚本 (Startup.bat)
notepad "%MountDir%\Windows\System32\Startup.bat"
wpeinit
Wpeutil WaitForRemovableStorage
Wpeutil InitializeNetwork
Wpeutil WaitForNetwork
Wpeutil DisableFirewall
netsh interface ipv4 set address name="Ethernet0" source=static address=192.168.255.250 mask=255.255.255.0
net user Administrator 123456
net start LanmanServer
net share X=X: /grant:everyone,FULL
ipconfig
wmic logicaldisk get caption,volumename,size
TYPE %SYSTEMROOT%\System32\note.txt
%SYSTEMROOT%\System32\cmd.exe
