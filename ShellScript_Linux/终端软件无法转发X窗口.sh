# 终端软件无法转发X窗口

apt install xauth x11-utils x11-apps x11-xserver-utils -y
xauth generate :0 . trusted
firewall-cmd --permanent --add-port=6000-6063/tcp
export DISPLAY=localhost:10.0

vim /etc/ssh/sshd_config
# X11Forwarding yes

systemctl restart sshd
systemctl restart firewalld

xeyes
xclock
xcalc
