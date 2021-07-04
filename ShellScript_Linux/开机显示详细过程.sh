vim /etc/default/grub
vim /boot/grub/grub.conf
vim /boot/grub2/grub.cfg
grub2-mkconfig -o /boot/grub2/grub.cfg

# UEFI：
vim /boot/efi/EFI/centos/grub.cfg
grub2-mkconfig -o /boot/efi/EFI/centos/grub.cfg

# CentOS:
vim /etc/grub.d
vim /etc/default/grub

# 开机画面关闭。
# 删除 rhgb quiet 。