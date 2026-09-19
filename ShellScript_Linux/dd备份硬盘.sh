# dd备份硬盘

# 直接备份
dd if=/dev/sdb of=/home/yashi/桌面/全盘备份.img

# 压缩备份
dd if=/dev/sdb | xz -z -9 -e -T 0 -v -c >/home/yashi/桌面/全盘备份.img.xz

# 恢复直接备份
dd if=/home/yashi/桌面/全盘备份.img of=/dev/sdb

# 恢复压缩备份
xz -d -v /home/yashi/桌面/全盘备份.img.xz -c | dd of=/dev/sdb

# 同步读取和压缩块大小，最低优先级
dd if=/dev/sdc bs=64M | nice -n 19 xz -e -9 --lzma2=dict=64MiB --threads=0 -c -v > ~/SIDK.img.xz

# 怎样确定 sdb1 的 USB设备名称？
udevadm info --query=all --name=/dev/sdb | grep -E "ID_VENDOR|ID_MODEL"
