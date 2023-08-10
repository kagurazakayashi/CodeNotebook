yum install epel-release
yum groupinstall "X Window system" "xfce" -y
yum install adobe-source-han-sans-cn-fonts adobe-source-code-pro-fonts -y

# VNC
yum install vnc-server
cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:1.service
vi /etc/systemd/system/vncserver@:1.service
# 将
# ExecStart=/sbin/runuser -l <USER>-c "/usr/bin/vncserver %i"
# PIDFile=/home/<USER>/.vnc/%H%i.pid
# 这两行中的替换为需要通过vnc远程登录的用户名。第二行的/home/是用户的home目录；如果是root则是/root，PIDFile=/root/.vnc/%H%i.pid。
systemctl daemon-reload
systemctl enable vncserver@:1.service
firewall-cmd --permanent --add-service vnc-server
systemctl restart firewalld.service

# startx
vi ~/.xinitrc
exec xfce4

# Xfce
vi /root/.vnc/xstartup
#!/bin/sh
# Uncomment the following two lines for normal desktop:
unset SESSION_MANAGER
#exec /etc/X11/xinit/xinitrc
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
xsetroot -solid grey
vncconfig -iconic &
startxfce4 &

systemctl start vncserver@:1.service


# CentOS8服务可用
vim /etc/systemd/system/vncserver@.service

[Unit]
Description=Remote Desktop VNC Service
After=syslog.target network.target
[Service]
Type=forking
WorkingDirectory=/root
User=root
Group=root
ExecStartPre=/bin/sh -c '/usr/bin/vncserver -kill :%i > /dev/null 2>&1 || :'
ExecStart=/usr/bin/vncserver -autokill :%i
ExecStop=/usr/bin/vncserver -kill :%i
[Install]
WantedBy=multi-user.target