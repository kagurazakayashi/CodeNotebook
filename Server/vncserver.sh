# Ubuntu
apt install xfce4 xfce4-goodies tigervnc-standalone-server -y
# CentOS
yum groupinstall "X Window system" "xfce4" -y
# View
vncviewer xxx:5901
# Start
vncserver -localhost no -geometry 1024x768 -depth 24
# Close
vncserver -kill :1

# vncserver [:<number>]            启动编号
# [-dry-run]             不采取实际行动
# [-verbose]             输出详细信息
# [-useold]              仅在尚未运行时启动VNC服务
# [-name <desktop-name>] VNC桌面名称
# [-depth <depth>]       桌面位深度 (8|16|24|32)
# [-pixelformat          x11服务器像素格式
#     rgb888|rgb565|rgb332   以低位编码的蓝色通道
#     |bgr888|bgr565|bgr233]  以低位编码的红色通道
# [-geometry <dim>]      分辨率 <width>x<height>
# [-xdisplaydefaults]    从x获取分辨率
# [-wmDecoration <dim>]  按尺寸缩小xDisplayDefaults中的分辨率
# [-localhost yes|no]    仅接受来自本地主机的VNC连接
# [-rfbport port]        用于侦听RFB协议的TCP端口
# [-httpPort     port]   内部HTTP服务器端口
# [-baseHttpPort port]   从基本端口计算HTTP端口 + display

vim ~/.vnc/xstartup

#!/bin/sh
xrdb $HOME/.Xresources
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
vncconfig -iconic &
xfce4-session & startxfce4 &

xfce4 插件
yum install xfce4-*-plugin
yum install adwaita-cursor-theme adwaita-gtk2-theme adwaita-icon-theme -y
apt install xfce4-goodies -y
apt install xfce4-*-plugin -y
apt install adwaita-icon-theme-full gnome-themes-extra gnome-themes-extra-data -y