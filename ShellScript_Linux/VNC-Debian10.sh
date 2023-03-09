# 安装Xfce桌面环境
sudo apt install xfce4 xfce4-goodies -y
sudo apt install "xfce4-*" -y
sudo apt install x11-xserver-utils dconf-editor dbus-x11 -y # dbus-launch
sudo apt install fcitx dbus-x11 fcitx-libs fcitx-sunpinyin -y # 输入法
# 安装TightVNC服务器
sudo apt install tightvncserver -y
# 设置安全密码并创建初始配置文件，密码长度必须介于六到八个字符之间
vncserver
# 关闭默认启动的VNC
vncserver -kill :1

# 配置VNC服务器，建议先cp备份
vim ~/.vnc/xstartup
# xfce4：
#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &

# 设置为系统服务
sudo vim /etc/systemd/system/vncserver@.service

[Unit]
Description=Start TightVNC server at startup
After=syslog.target network.target
[Service]
Type=forking
User=root
Group=root
WorkingDirectory=/root
PIDFile=/root/.vnc/%H:%i.pid
ExecStartPre=-/usr/bin/vncserver -kill :%i > /dev/null 2>&1
ExecStart=/usr/bin/vncserver -depth 24 -geometry 1280x720 :%i
ExecStop=/usr/bin/vncserver -kill :%i
[Install]
WantedBy=multi-user.target

# 重载系统服务
sudo systemctl daemon-reload
sudo systemctl enable vncserver@1.service

# 用以下命令设置默认的启动项目：
update-alternatives --config x-window-manager

# 官方介绍： https://wiki.debian.org/zh_CN/Xfce