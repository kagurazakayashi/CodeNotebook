# 类型1：内核级/mnt/ramdisk
# 查看一下可用的RamDisk
ls /dev/ram*
# 创建一个目录
mkdir /mnt/ramdisk;
# 创建文件系统
mke2fs /dev/ram0;
# 挂载 /dev/ram0
mount /dev/ram /mnt/ramdisk

# 类型2：纯内存盘
mkdir /mnt/ramdisk
# 最多可使用内存大小的一半
mount -t ramfs none /mnt/ramdisk
# 或通过maxsize(没有单位以kbyte为单位)选项来改变最多可使用内存大小
mount -t ramfs -o size=32m ext4 /mnt/ramdisk
mount -t ramfs none /mnt/ramdisk -o maxsize=6000m
mount ramfs /mnt/ramdisk -t ramfs -o size=6000m

# 类型3：也可用虚拟内存
mkdir -p /mnt/ramdisk
mount tmpfs /mnt/ramdisk -t tmpfs
mount tmpfs /mnt/ramdisk -t tmpfs -o size=6000m

# 自动挂载
vim /etc/fstab
tmpfs /mnt/ramdisk tmpfs defaults,size=1G,x-gvfs-show 0 0
# x-gvfs-show选项可以让你在文件管理器中看到你的 RAM Disk。

# 卸载
umount /mnt/ramdisk


# https://blog.csdn.net/zzqhost/article/details/71307690
# https://linuxhint.com/ramdisk_ubuntu_1804/

# 测试RAM disk速度
# 测试RAM disk的写入速度，我们可以用dd工具。
sudo dd if=/dev/zero of=/mnt/ramdisk/zero bs=4k count=10000

# 测试读取速度，运行下面的命令：
sudo dd if=/mnt/ramdisk/zero of=/dev/null bs=4k count=10000

rm /mnt/ramdisk/zero

# https://www.linuxdashen.com/%E4%B8%BA%E4%BD%A0%E7%9A%84linux%E7%B3%BB%E7%BB%9F%E5%88%9B%E5%BB%BAram-disk


# modprobe内核功能方式

#!/bin/sh
echo RAMDISK 32MB FAT16
/usr/sbin/modprobe brd rd_nr=1 rd_size=32000 max_part=0
/usr/sbin/mkfs.msdos /dev/ram0
/usr/bin/mount -o rw,uid=1000,gid=1000,x-gvfs-show /dev/ram0 /home/yashi/ramdisk -t msdos

#!/bin/sh
echo RAMDISK 8GB EXT4
/usr/sbin/modprobe brd rd_nr=1 rd_size=8000000 max_part=0
/usr/sbin/mkfs.ext4 /dev/ram0
/usr/bin/mount -o rw,x-gvfs-show /dev/ram0 /r -t ext4

# 卸载
umount /r
modprobe -r brd

# https://lala.im/4559.html
