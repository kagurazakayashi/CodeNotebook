bcdedit /copy {current} /d "Windows 11 Safe Mode"
bcdedit /set {xxxx} safeboot minimal
bcdedit /copy {current} /d "Windows 11 Safe Mode Networking"
bcdedit /set {xxxx} safeboot network
bcdedit /copy {current} /d "Windows 11 Safe Mode CMD"
bcdedit /set {xxxx} safeboot minimal
bcdedit /set {xxxx} safebootalternateshell yes
禁用 Hyper-V:
bcdedit /copy {current} /d "Windows 11 no Hyper-V"
bcdedit /set {xxxx} hypervisorlaunchtype off

REM 禁用多次重启后运行自动修复功能
bcdedit /set {current} recoveryenabled no

REM 旧版 Windows:
notepad C:\boot.ini
REM 复制一行启动项，保存文件
msconfig
REM 配置上述 /SAFEBOOT
