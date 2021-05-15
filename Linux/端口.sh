# Linux查看端口占用情况和开启端口命令

# 查看端口的使用的情况
# lsof 命令

# 比如查看80端口的使用的情况。
lsof -i tcp:80

# 列出所有的端口
netstat -ntlp

# 查看端口的状态
/etc/init.d/iptables status

# iptables 开启端口: 以开启端口80为例
iptables -I INPUT -p tcp --dport 80 -j ACCEPT
/etc/init.d/iptables save
/etc/sysconfig/iptables restart
# 关闭端口
iptables -I INPUT -p tcp --dport 80 -j DROP
/etc/init.d/iptables save
service iptables restart

# https://blog.csdn.net/ljbmxsm/article/details/50650008