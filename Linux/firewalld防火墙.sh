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
# 限制IP地址访问 限制IP为192.168.0.200的地址禁止访问80端口
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="192.168.0.200" port protocol="tcp" port="80" reject'
# 解除IP地址限制 解除刚才被限制的192.168.0.200
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="192.168.0.200" port protocol="tcp" port="80" accept'
# 限制IP地址段 限制10.0.0.0-10.0.0.255这一整个段的IP
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="10.0.0.0/24" port protocol="tcp" port="80" reject'
# 解除限制IP地址段 允许10.0.0.0-10.0.0.255这一整个段的IP
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="10.0.0.0/24" port protocol="tcp" port="80" accept'
# 其中10.0.0.0/24表示为从10.0.0.0这个IP开始，24代表子网掩码为255.255.255.0，共包含256个地址，即从0-255共256个IP，即正好限制了这一整段的IP地址

# 直接编辑规则文件
vim /etc/firewalld/zones/public.xml



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
firewall-cmd --permanent --add-rich-rule='rule family=ipv4 source address="103.43.17.18" drop'

# 允许IP： 
firewall-cmd --permanent --add-rich-rule='rule family=ipv4 source address="47.88.6.186" accept'

# 添加服务： 
firewall-cmd --permanent --add-service vnc-server 

# 允许端口： 
firewall-cmd --permanent --add-port=3128/tcp 

# 列出所有区域规则：
firewall-cmd --list-all-zones

# http://www.centoscn.com/CentOS/Intermediate/2015/0313/4879.html