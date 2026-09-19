# SSH启用X11转发
vim /etc/ssh/sshd_config
# 添加:
X11Forwarding yes
X11DisplayOffset 10
X11UseLocalhost yes

# 然后重启服务:
systemctl restart sshd
