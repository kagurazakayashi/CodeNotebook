# Debian12 开机自动解密LUKS分区 加密分区

# 向钥匙串文件中添加密钥
sudo /etc/initramfs-tools/conf.d/cryptsetup luksAddKey /dev/vdb /crypto_keyfile.bin

# 开机自动挂载加密盘列表
sudo vim /etc/crypttab

# 开机自动挂载普通盘列表
sudo vim /etc/fstab

# 配置grub引导菜单
sudo vim /etc/default/grub
sudo vim /boot/grub/grub.cfg

# 自动添加的可能会在以下各个脚本中：
sudo vim /etc/grub.d/proxifiedScripts/custom
sudo vim /etc/default/grub.ucf-dist

# cryptsetup waiting for encrypted source device uuid
