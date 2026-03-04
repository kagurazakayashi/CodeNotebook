@echo off
cd /d "%~dp0"
echo Uninstalling ...
CLS
install_wim_tweak.exe /o /l
install_wim_tweak.exe /o /c "Windows-Defender" /r
install_wim_tweak.exe /h /o /l
echo It should be uninstalled. Please reboot Windows 10.
pause

REM 当前系统列表
install_wim_tweak /o /l
REM 其他系统列表
install_wim_tweak /p D:\win10 /l

REM 假设此处精简win10安装文件挂载到了D盘win10目录，那么我测试过可精简内容和命令如下：
REM 如果在线精简系统，则替换"/p d:\win10"为"/o"即可。
REM :Cortana
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-Cortana
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-OneCore-CortanaComponents
REM :EDGE
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-Internet-Browser
REM :联系支持
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-ContactSupport
REM :Windows反馈
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-WindowsFeedback
REM :EDGE的SKYPE在线通话插件
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-Skype-ORTC
REM :XBOX相关
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Xbox-GameCallableUI
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Xbox-IdentityProvider
REM :OneDirve安装文件
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-OneDrive-Setup
REM :离线文件
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-OfflineFiles
REM :移动中心
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-MobilePC
REM :便笺
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-StickyNotes
REM :系统还原
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-SystemRestore
REM :旧版功能DirectPlay
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-DirectPlay
REM :Windows media player
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-MediaPlayer
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-WindowsMediaPlayer-Troubleshooters
REM :远程差分压缩API支持
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-RDC
REM :XPS查看器
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-Xps
REM :XPS服务
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-Printing-XPSServices
REM :RAS连接管理器管理工具包（CMAK）
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-RasCMAK
REM :RIP侦听器
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-RasRip
REM :简单TCPIP服务
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-SimpleTCP
REM :简单网络管理协议
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-SNMP
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-WMI-SNMP-Provider
REM :工作文件夹客户端
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-EnterpriseClientSync
REM :Multipoint Connector
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-MultiPoint-Connector
REM :Active Directory轻型目录服务
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-DirectoryServices-ADAM-Client
install_wim_tweak.exe /p d:\win10 /r /c microsoft-windows-directoryservices-adam-snapins
REM :隔离用户模式（服务器相关）
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-IsolatedUserMode
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-OneCore-IsolatedUserMode-Required
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-IsolatedUserMode-Opt
REM :Hyper V虚拟化相关
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Hyper-V
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-RemoteFX-Graphics
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-RemoteFX-HyperV-Integration
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-RemoteFX-RemoteClient-Setup
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-RemoteFX-VM-Setup
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-Virtualization-RemoteFX-User-Mode-Transport
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-VirtualPC
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-VirtualXP
REM :MSMQ服务器
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-COM-MSMQ
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-MSMQ-Client
REM :Microsoft-Windows-NetFx-Shared-WCF-MsmqActivation
REM 混合现实门户
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-ContactSupport