# 网卡跃点数控制

# 列出网卡 ID 和 跃点数
Get-NetIPInterface | Sort-Object InterfaceMetric | Select-Object InterfaceAlias, InterfaceIndex, InterfaceMetric, AddressFamily | ft -AutoSize

# 设置网卡 ID 为 21 的跃点数:
Set-NetIPInterface -InterfaceIndex 21 -InterfaceMetric 10

# 强制让访问 117 网段的流量走网卡 5
route add 192.168.117.0 mask 255.255.255.0 192.168.117.1 if 5 -p
# -p: 永久生效（Persistent）


# 使用命令设置静态路由：
# 网卡：21，网关：192.168.1.1，IPv4跃点1，IPv6跃点2
# 网卡：5，网关：192.168.117.1，IPv4跃点3，IPv6跃点4
# 设置 21 IPv4 跃点数为 1
Set-NetIPInterface -InterfaceIndex 21 -AddressFamily IPv4 -InterfaceMetric 1
# 设置 21 IPv6 跃点数为 2
Set-NetIPInterface -InterfaceIndex 21 -AddressFamily IPv6 -InterfaceMetric 2
# 设置 5 IPv4 跃点数为 3
Set-NetIPInterface -InterfaceIndex 5 -AddressFamily IPv4 -InterfaceMetric 3
# 设置 5 IPv6 跃点数为 4
Set-NetIPInterface -InterfaceIndex 5 -AddressFamily IPv6 -InterfaceMetric 4
# 删除所有通过网卡 21 出去的路由
Remove-NetRoute -InterfaceIndex 21 -AddressFamily IPv4 -Confirm:$false
Remove-NetRoute -InterfaceIndex 21 -AddressFamily IPv6 -Confirm:$false
# 删除所有通过网卡 5 出去的路由
Remove-NetRoute -InterfaceIndex 5 -AddressFamily IPv4 -Confirm:$false
Remove-NetRoute -InterfaceIndex 5 -AddressFamily IPv6 -Confirm:$false
# 为网卡 21 添加默认网关：
New-NetRoute -DestinationPrefix "0.0.0.0/0" -NextHop "192.168.1.1" -InterfaceIndex 21 -RouteMetric 1
# 为网卡 5 添加特定的内网路由（117 网段）：
New-NetRoute -DestinationPrefix "192.168.117.0/24" -NextHop "192.168.117.1" -InterfaceIndex 5 -RouteMetric 2
# 检查接口优先级确认这里的数字
Get-NetIPInterface -InterfaceIndex 21, 5 | Select-Object InterfaceAlias, InterfaceIndex, AddressFamily, InterfaceMetric
# 检查路由表实际状态，查看 0.0.0.0 对应的两条路由
# 其中“永久路由”就是上面用 route add -p 或 New-NetRoute 添加的内容
route print -4
route print -6
# 测试路径，第一跳现在应该固定为 192.168.1.1。
tracert -d 223.5.5.5

# GUI
# 查看网卡
C:\tools\NirLauncher\NirSoft\NetworkCountersWatch.exe
# 查看路由
C:\tools\NirLauncher\NirSoft\netrouteview.exe
