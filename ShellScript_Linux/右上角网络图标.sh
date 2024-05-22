# xfce 右上角的网络图标怎么开启？
systemctl status NetworkManager
sudo systemctl start NetworkManager
xfce4-panel --restart

# 右键点击 XFCE 面板空白处，选择“面板” -> “添加新项目...”。
# 在列表中找到“网络管理器”或者“网络”相关的插件。
# 选择它，然后点击“添加”。

# Arch Linux
sudo pacman -S network-manager-applet
sudo systemctl enable --now NetworkManager
pacman -Qs network-manager-applet
xfce4-panel --restart
