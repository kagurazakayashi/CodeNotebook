# Centos 8 / RHEL 8 上安装和配置 VNC 服务器
dnf groupinstall "workstation"
dnf groupinstall "Server with GUI"

# 主机默认启用图形模式
systemctl set-default graphical
# 主机默认启用命令行模式
systemctl set-default multi-user

vim /etc/gdm/custom.conf
# WaylandEnable=false

dnf install tigervnc-server tigervnc-server-module -y
vncpasswd

vim /etc/systemd/system/vncserver@.service
[Unit]
Description=Remote Desktop VNC Service
After=syslog.target network.target
[Service]
Type=forking
WorkingDirectory=/home/用户名
User=用户名
Group=用户组
ExecStartPre=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'
ExecStart=/usr/bin/vncserver -autokill %i
ExecStop=/usr/bin/vncserver -kill %i
[Install]
WantedBy=multi-user.target

systemctl daemon-reload
systemctl start vncserver@:1.service
systemctl status vncserver@:1.service
systemctl enable vncserver@:1.service
firewall-cmd --permanent --add-port=5901/tcp
firewall-cmd --reload

systemctl start vncserver@:1.service && systemctl status vncserver@:1.service
systemctl stop vncserver@:1.service && systemctl status vncserver@:1.service