# 安装Xfce桌面环境
apt install xfce4 xfce4-goodies
# 安装TightVNC服务器
apt install tightvncserver
# 设置安全密码并创建初始配置文件，密码长度必须介于六到八个字符之间
vncserver
# 关闭默认启动的VNC
vncserver -kill :1
# 配置VNC服务器，建议先cp备份
vim ~/.vnc/xstartup

# xfce4：
# #!/bin/bash
# xrdb $HOME/.Xresources
# startxfce4 &

# 设置为系统服务
sudo vim /etc/systemd/system/vncserver@.service

# [Unit]
# Description=Start TightVNC server at startup
# After=syslog.target network.target

# [Service]
# Type=forking
# User=root
# Group=root
# WorkingDirectory=/root

# PIDFile=/root/.vnc/%H:%i.pid
# ExecStartPre=-/usr/bin/vncserver -kill :%i > /dev/null 2>&1
# ExecStart=/usr/bin/vncserver -depth 24 -geometry 1280x720 :%i
# ExecStop=/usr/bin/vncserver -kill :%i

# [Install]
# WantedBy=multi-user.target

systemctl daemon-reload
systemctl enable vncserver@1.service