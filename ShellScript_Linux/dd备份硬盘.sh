# dd备份

# 直接备份
sudo dd if=/dev/sdb of=/home/yashi/桌面/全盘备份.img

# 压缩备份
sudo dd if=/dev/sdb | xz -z -9 -e -T 0 -v -c >/home/yashi/桌面/全盘备份.img.xz

# 恢复直接备份
sudo dd if=/home/yashi/桌面/全盘备份.img of=/dev/sdb

# 恢复压缩备份
sudo xz -d -v /home/yashi/桌面/全盘备份.img.xz -c | sudo dd of=/dev/sdb
