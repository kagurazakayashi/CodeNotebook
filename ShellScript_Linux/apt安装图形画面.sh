# 查看当前桌面环境
echo $DESKTOP_SESSION
# 开机后在登录界面可以选择要使用的桌面环境。

# apt安装图形画面
sudo apt install task-xfce-desktop
sudo dpkg-reconfigure lightdm

sudo apt install task-gnome-desktop
sudo dpkg-reconfigure gdm3

sudo apt install task-kde-desktop
sudo dpkg-reconfigure sddm

sudo apt install "xfce-*"
sudo apt install "gnome-*"
sudo apt install "kde-*"

# 查看当前显示管理器
cat /etc/X11/default-display-manager
