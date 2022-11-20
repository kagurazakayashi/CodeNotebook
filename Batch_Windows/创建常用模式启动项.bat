bcdedit /copy {current} /d "Windows 11 Safe Mode"
bcdedit /copy {current} /d "Windows 11 Safe Mode with Networking"
msconfig
REM 配置上述。禁用 Hyper-V ：
bcdedit /copy {current} /d "Windows 11 no Hyper-V"
bcdedit /set {498bb229-799c-11eb-9f8b-acd53edf9321} hypervisorlaunchtype off

REM 旧版 Windows:
notepad C:\boot.ini
REM 复制一行启动项，保存文件
msconfig
REM 配置上述 /SAFEBOOT