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
