# 查看防火墙状态
systemctl status firewalld
# 开启防火墙并设置开机自启
systemctl start firewalld
systemctl enable firewalld
# 停止
systemctl stop firewalld

# 修改后
# 重新载入防火墙设置，使设置生效
firewall-cmd --reload
# 查看是否生效
firewall-cmd --zone=public --query-port=22/tcp

# 查询
# 查看当前系统打开的所有端口
firewall-cmd --zone=public --list-ports
# 查看已经设置的规则
firewall-cmd --zone=public --list-rich-rules

# 开放端口
firewall-cmd --zone=public --add-port=22/tcp --permanent
# --permanent的作用是使设置永久生效
# 限制端口
firewall-cmd --zone=public --remove-port=22/tcp --permanent
# 批量开放 从100到500之间的端口全部打开
firewall-cmd --zone=public --add-port=100-500/tcp --permanent
# 批量限制 从100到500之间的端口全部限制
firewall-cmd --zone=public --remove-port=100-500/tcp --permanent

# 开放或限制IP
# REJECT:回复拒绝  DROP:直接丢弃
#禁止IP(123.56.161.140)访问机器
firewall-cmd --permanent --add-rich-rule='rule family=ipv4 source address="123.56.161.140" drop'
# 限制IP地址访问 限制IP为192.168.0.200的地址禁止访问80端口
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="192.168.0.200" port protocol="tcp" port="80" reject'
# 解除IP地址限制 解除刚才被限制的192.168.0.200
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="192.168.0.200" port protocol="tcp" port="80" accept'
# 限制IP地址段 限制10.0.0.0-10.0.0.255这一整个段的IP
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="10.0.0.0/24" port protocol="tcp" port="80" reject'
# 解除限制IP地址段 允许10.0.0.0-10.0.0.255这一整个段的IP
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="10.0.0.0/24" port protocol="tcp" port="80" accept'
# 其中10.0.0.0/24表示为从10.0.0.0这个IP开始，24代表子网掩码为255.255.255.0，共包含256个地址，即从0-255共256个IP，即正好限制了这一整段的IP地址

# 防火墙的区域
# 查看默认区域
firewall-cmd --get-default-zone
# 修改默认区域：
firewall-cmd --set-default-zone=internal
# 查看你网络接口使用的区域：
firewall-cmd --get-active-zones
# 得到特定区域的所有配置
firewall-cmd --zone=public --list-all
# 得到所有区域的配置： 
firewall-cmd --list-all-zones

# 与服务一起使用
# 要查看默认的可用服务：
firewall-cmd --get-services
# 比如，要启用或禁用 HTTP 服务： 
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --zone=public --remove-service=http --permanent

# 充许或者拒绝任意端口/协议
# 允许12345 端口的 TCP 流量。
firewall-cmd --zone=public --add-port=12345/tcp --permanent
# 禁用 12345 端口的 TCP 流量。
firewall-cmd --zone=public --remove-port=12345/tcp --permanent
# 允许12345 端口的 UDP 流量。
firewall-cmd --zone=public --add-port=12345/udp --permanent
# 禁用 12345 端口的 UDP 流量。
firewall-cmd --zone=public --remove-port=12345/udp --permanent
# 查看8080端口的tcp协议是否被充许
firewall-cmd --zone=public --query-port=8080/tcp
# 查看所有打开的端口：
firewall-cmd --zone=public --list-ports

# IP伪装
# 检查是否允许伪装IP
firewall-cmd --query-masquerade
# 允许防火墙伪装IP
firewall-cmd --add-masquerade
# 禁止防火墙伪装IP
firewall-cmd --remove-masquerade

# 端口转发
# 端口转发可以将指定地址访问指定的端口时，将流量转发至指定地址的指定端口。转发的目的如果不指定ip的话就默认为本机，如果指定了ip却没指定端口，则默认使用来源端口。
# 如果配置好端口转发之后不能用，可以检查下面两个问题：
# 比如我将80端口转发至8080端口，首先检查本地的80端口和目标的8080端口是否开放监听了其次检查是否允许伪装IP，没允许的话要开启伪装IP
# 下面是在同一台服务器上将 80 端口的流量转发到 12345 端口。
firewall-cmd --zone="public" --add-forward-port=port=80:proto=tcp:toport=12345 --permanent
# 将本服务的8056端口转发到ip地址为XXX.XX.XX.XXX的3356端口上,只能使用IP地址，不能使用主机名：
firewall-cmd --permanent --zone=public --add-forward-port=port=8056:proto=tcp:toaddr=xxx.xx.xx.xxx:toport=3356
# 将端口转发到另外一台服务器上：
# 1、 在需要的区域中激活 masquerade。
firewall-cmd --zone=public --add-masquerade
# 2、 添加转发规则。例子中是将本地的 80 端口的流量转发到 IP 地址为 ：123.456.78.9 的远程服务器上的  8080 端口
firewall-cmd --zone="public" --add-forward-port=port=80:proto=tcp:toport=8080:toaddr=123.456.78.9
# 要删除规则，用 --remove 替换 --add。比如：
firewall-cmd --zone=public --remove-masquerade
# 查看转发列表
firewall-cmd --list-forward-ports
# 输出 port=4489:proto=tcp:toport=3389:toaddr=192.168.1.55
# 添加删除
firewall-cmd --permanent --add-forward-port=port=80:proto=tcp:toport=3000
firewall-cmd --permanent --remove-forward-port=port=80:proto=tcp:toport=3000
firewall-cmd --reload

# 用FirewallD构建规则集
# 1、将 eth0 的默认区域设置为 dmz。 在所提供的默认区域中，dmz（非军事区）是最适合于这个程序的，因为它只允许 SSH 和 ICMP。
firewall-cmd --set-default-zone=dmz
firewall-cmd --zone=dmz --add-interface=eth0

# 2、 把 HTTP 和 HTTPS 添加永久的服务规则到 dmz 区域中：
firewall-cmd --zone=dmz --add-service=http --permanent
firewall-cmd --zone=dmz --add-service=https --permanent

# 3、 重新加载 FirewallD 让规则立即生效：
firewall-cmd --reload

# 高级配置
# 允许来自主机 192.168.0.14 的所有 IPv4 流量。
firewall-cmd --zone=public --add-rich-rule 'rule family="ipv4" source address=192.168.0.14 accept'
# 拒绝来自主机 192.168.1.10 到 22 端口的 IPv4 的 TCP 流量。
firewall-cmd --zone=public --add-rich-rule 'rule family="ipv4" source address="192.168.1.10" port port=22 protocol=tcp reject'
# 允许来自主机 10.1.0.3 到 80 端口的 IPv4 的 TCP 流量，并将流量转发到 6532 端口上。 
firewall-cmd --zone=public --add-rich-rule 'rule family=ipv4 source address=10.1.0.3 forward-port port=80 protocol=tcp to-port=6532'
# 将主机 172.31.4.2 上 80 端口的 IPv4 流量转发到 8080 端口（需要在区域上激活 masquerade）。
firewall-cmd --zone=public --add-rich-rule 'rule family=ipv4 forward-port port=80 protocol=tcp to-port=8080 to-addr=172.31.4.2'
# 列出你目前的丰富规则：
firewall-cmd --list-rich-rules

# 直接编辑规则文件
vim /etc/firewalld/zones/public.xml

# https://blog.51cto.com/mrxiong2017/2084726


# 暫時開放 ftp 服務
firewall-cmd --add-service=ftp
# 永久開放 ftp 服務
firewall-cmd --add-service=ftp --permanent
# 永久關閉
firewall-cmd --remove-service=ftp --permanent
# 讓設定生效
systemctl restart firewalld
# 檢視設定是否生效
iptables -L -n | grep 21

# 檢查防火牆狀態
firewall-cmd --state
# 停止
systemctl stop firewalld
# 规则列表
firewall-cmd --list-all
# 支持的服务列表
firewall-cmd --get-service
# 查詢服務的啟用狀態
firewall-cmd --query-service ftp

# 添加端口
firewall-cmd --zone=public --add-port=80/tcp --permanent
# 删除端口
firewall-cmd --zone=public --add-port=80/tcp --permanent
# --zone #作用域
# --add-port=80/tcp  #添加端口，格式为：端口/通讯协议
# --permanent   #永久生效，没有此参数重启后失效

# 防火墙firewall操作
systemctl start firewalld
systemctl status firewalld
firewall-cmd --state
systemctl stop firewalld
systemctl restart firewalld



# Cent OS 7:
systemctl restart firewalld.service 

# 屏蔽IP：
# REJECT:回复拒绝  DROP:直接丢弃
firewall-cmd --permanent --add-rich-rule='rule family=ipv4 source address="103.43.17.18" drop'

# 允许IP： 
firewall-cmd --permanent --add-rich-rule='rule family=ipv4 source address="47.88.6.186" accept'

# 添加服务： 
firewall-cmd --permanent --add-service vnc-server 

# 允许端口： 
firewall-cmd --permanent --add-port=3128/tcp 

# 列出所有区域规则：
firewall-cmd --list-all-zones

# 重新加载 FirewallD 让规则立即生效
firewall-cmd --reload

# http://www.centoscn.com/CentOS/Intermediate/2015/0313/4879.html