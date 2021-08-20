# 获取客户端MAC地址和主机名

# 安装相关命令
sudo apt-get install net-tools -y

# 先ping对方的IP，使本机与之产生通信，从而缓存对方的MAC
ping 对方IP

# 查对方的MAC地址
arp -a 对方IP

# 查看arp缓存的所有IP/MAC
arp -a

# 查对方的主机名
# Windows
nbtstat -a 对方IP
# Linux (在 samba 包里)
nmblookup -A 对方IP