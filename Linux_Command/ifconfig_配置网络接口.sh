# 配置网络接口
ifconfig
# ifconfig [网卡名称] [选项]
# netmask   子网掩码
# broadcast 广播地址
# up        激活接口
# down      关闭接口

# 将 IP 地址设置为 192.168.1.2
ifconfig eth0 192.168.1.2

# 设置子网掩码为 255.255.255.0
ifconfig eth0 netmask 255.255.255.0

# 设置广播地址为 192.168.1.255
ifconfig eth0 broadcast 192.168.1.255

# 关闭网卡 eth0
ifconfig eth0 down

# 激活网卡 eth0
ifconfig eth0 up