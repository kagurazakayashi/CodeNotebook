# 树莓派等 Linux 设备挂载 U 盘或移动硬盘
sudo mkdir /mnt/usb
# sudo mount -o uid=用户,gid=组 /dev/设备 /mnt/挂载文件夹
sudo mount -o uid=pi,gid=pi /dev/sda1 /mnt/usb
ls /mnt/usb
# 用完后卸载
sudo umount /mnt/usb