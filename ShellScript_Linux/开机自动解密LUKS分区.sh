# Debian12 开机自动解密LUKS分区 加密分区

# 向钥匙串文件中添加密钥
sudo /etc/initramfs-tools/conf.d/cryptsetup luksAddKey /dev/vdb /crypto_keyfile.bin

# 开机自动挂载加密盘列表
sudo vim /etc/crypttab

# 开机自动挂载普通盘列表
sudo vim /etc/fstab

# 配置grub引导菜单
nano vim /etc/default/grub
nano vim /boot/grub/grub.cfg
