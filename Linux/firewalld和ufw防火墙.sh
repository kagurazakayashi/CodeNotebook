chown -R www:www /home/wwwroot/
chmod 777 filename

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

# ====================

# Ubuntu 14:

apt-get install ufw
ufw enable

# 默认禁用：
ufw default deny

# 允许端口：
ufw allow 22/tcp

# 禁止端口：
ufw deny 22/tcp

# 删除规则：
ufw delete deny 22/tcp

# 允许此IP访问所有的本机端口：
ufw allow from 123.56.133.111

# 禁止此IP访问所有的本机端口：
ufw deny from 103.43.17.18

# 查看防火墙状态：
ufw status

# 删除上面建立的某条规则：
ufw delete allow smtp

# 防火墙规则文件路径：
/lib/ufw/user.rules

# 关闭防火墙：
ufw disable
