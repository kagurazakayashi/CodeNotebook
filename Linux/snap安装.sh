# centos8
dnf install epel-release -y
dnf install snapd -y
systemctl enable --now snapd.socket
ln -s /var/lib/snapd/snap /snap
# 重新登录

# 如何使用snap
# 如果您正在运行Ubuntu 16.04 LTS或更高版本，您可以在命令行中使用snap。

# 列出计算机上所有snap安装情况：
sudo snap list

# 在应用商店中查找snap：
sudo snap find <软件包名>

# 安装Snap软件：
sudo snap install <snap软件包名>

# 更新Snap软件：
sudo snap refresh <snap软件包名>

# 更新所有的snap软件包：
sudo snap refresh all

# 要将Snap还原到以前安装的版本：
sudo snap revert <snap软件包名>

# 卸载snap软件：
sudo snap remove <snap软件包名>