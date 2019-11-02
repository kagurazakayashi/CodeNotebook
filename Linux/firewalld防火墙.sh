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