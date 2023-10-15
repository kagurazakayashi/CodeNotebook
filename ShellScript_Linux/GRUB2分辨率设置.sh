# 如何安全地更改GRUB2屏幕分辨率？

# 重新启动并按住Shift键显示您的grub。 按C进入控制台模式。 然后输入：（不能在安全启动下）
vbeinfo
# 会列出所有支持的分辨率
 
# 在grub中设置分辨率
sudo nano /etc/default/grub
GRUB_GFXMODE=1920x1080,auto

# 保存更改
sudo update-grub

# 不要启动图形模式：
GRUB_TERMINAL=console

# 图形自定义程序：
apt install grub-customizer -y
