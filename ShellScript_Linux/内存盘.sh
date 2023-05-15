# 类型1：内核级
# 查看一下可用的RamDisk
ls /dev/ram*
# 创建一个目录
mkdir /mnt/vram;
# 创建文件系统
mke2fs /dev/ram0;
# 挂载 /dev/ram0
mount /dev/ram /mnt/vram

# 类型2：纯内存盘
mkdir /mnt/vram
# 最多可使用内存大小的一半
mount -t ramfs none /mnt/vram
# 或通过maxsize(没有单位以kbyte为单位)选项来改变最多可使用内存大小
mount -t ramfs none /mnt/vram -o maxsize=6000m
mount ramfs /mnt/vram -t ramfs -o size=6000m

# 类型3：也可用虚拟内存
mkdir -p /mnt/vram
mount tmpfs /mnt/vram -t tmpfs
mount tmpfs /mnt/vram -t tmpfs -o size=6000m

# 自动挂载
vim /etc/fstab
tmpfs /mnt/vram tmpfs size=1024m 0 0

# 卸载
umount /mnt/vram


# https://blog.csdn.net/zzqhost/article/details/71307690
# https://linuxhint.com/ramdisk_ubuntu_1804/
