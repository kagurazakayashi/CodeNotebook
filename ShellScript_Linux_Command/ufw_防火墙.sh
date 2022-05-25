# Ubuntu 树莓派 Debian防火墙

apt-get install ufw
ufw enable

# 默认禁用：
ufw default deny

# 列出规则
ufw status

# 允许端口：
ufw allow 22/tcp

# 禁止端口：
ufw deny 22/tcp

# 删除规则：
ufw delete deny 22/tcp

# 允许特定IP访问所有的本机端口：
ufw allow from 192.168.1.1

# 禁止特定IP访问所有的本机端口：
ufw deny from 192.168.1.2

# 删除上面建立的某条规则：
ufw delete allow smtp

# 防火墙规则文件路径：
/lib/ufw/user.rules

# 关闭防火墙：
ufw disable
