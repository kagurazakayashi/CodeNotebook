# 端口转发远程桌面

# 让局域网中的其他电脑可以连接该虚拟机
# 虚拟机 IP 地址是 192.168.255.11
# 宿主机 IP 地址是 192.168.1.48

# 开启
netsh interface portproxy add v4tov4 listenaddress=192.168.1.48 listenport=3390 connectaddress=192.168.255.11 connectport=3389
New-NetFirewallRule -DisplayName "RDP Forward to VM 192.168.255.11" -Direction Inbound -Protocol TCP -LocalPort 3390 -RemoteAddress LocalSubnet -Action Allow

# 关闭
netsh interface portproxy delete v4tov4 listenaddress=192.168.1.48 listenport=3390
Remove-NetFirewallRule -DisplayName "RDP Forward to VM 192.168.255.11"

# 依赖 Windows 的 IP Helper（IP 帮助程序） 服务
Get-Service iphlpsvc
# 如果没运行：
Set-Service iphlpsvc -StartupType Automatic
Start-Service iphlpsvc
