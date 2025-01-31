@REM 用跳板机访问远程RDP
@ECHO OFF
chcp 65001
setlocal enabledelayedexpansion
SET WINTITLE=ChatGPT_RDP
TITLE %WINTITLE%
ECHO ChatGPT：RDP共享
SET DOMAIN=winserver.xxx.xxx
SET DNS_SERVER=223.5.5.5
SET LOCAL_PORT=3399
SET REMOTE_PORT=3389
SET BRIDGE=192.168.1.234
SET BRIDGE_USER=link
SET BRIDGE_CERT=xxx-link.pem
SET RDPFILE=ChatGPT_RDP.rdp
SET IP_TYPE="=AAAA"
SET IP_ADDRESS=
ECHO 正在从 %DNS_SERVER% 获取服务器 IPv6 地址
for /f "tokens=*" %%A in ('nslookup -type%IP_TYPE% %DOMAIN% %DNS_SERVER% ^| findstr "Address:"') do (
    SET LINE=%%A
    SET LINE=!LINE:~10!
    SET IP_ADDRESS=!LINE!
)
if "%IP_ADDRESS%"=="" (
    ECHO 错误：获取 IP 地址失败！
	EXIT
)
ECHO 服务器 IPv6 地址是 %IP_ADDRESS%
ECHO 正在登录本地 IPv4 网络桥 %BRIDGE% , 用户: %BRIDGE_USER% , 私钥: %BRIDGE_CERT%
ping %BRIDGE% -n 1
C:\Windows\System32\OpenSSH\ssh.exe %BRIDGE% -l %BRIDGE_USER% -i %BRIDGE_CERT% "ping %REMOTE_PORT% -c 1"
ECHO 正在建立端口映射: 从本地 IPv4 端口 %LOCAL_PORT% 到 远程 IPv6 端口 %REMOTE_PORT%
START "ChatGPT_RDP_SSH" /B /ABOVENORMAL C:\Windows\System32\OpenSSH\ssh.exe -N -L %LOCAL_PORT%:[%IP_ADDRESS%]:%REMOTE_PORT% %BRIDGE% -l %BRIDGE_USER% -i %BRIDGE_CERT%
TIMEOUT 1
netstat -ano | findstr :%LOCAL_PORT%
ECHO 建立远程桌面连接
C:\Windows\System32\mstsc.exe %RDPFILE%
ECHO 正在断开
TIMEOUT 1
TASKKILL /FI "WINDOWTITLE eq %WINTITLE%"
