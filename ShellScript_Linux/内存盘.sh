# 类型1：内核级
# 查看一下可用的RamDisk
ls /dev/ram*
# 创建一个目录
mkdir /mnt/r;
# 创建文件系统
mke2fs /dev/ram0;
# 挂载 /dev/ram0
mount /dev/ram /mnt/r

# 类型2：纯内存盘
mkdir /mnt/r
# 最多可使用内存大小的一半
mount -t ramfs none /mnt/r
# 通过maxsize(以kbyte为单位)选项来改变最多可使用内存大小
mount -t ramfs none /mnt/r -o maxsize=2000

# 类型3：也可用虚拟内存
mkdir -p /mnt/r
mount tmpfs /mnt/r -t tmpfs
mount tmpfs /mnt/r -t tmpfs -o size=32m

# 自动挂载
vim /etc/fstab
tmpfs /mnt/r tmpfs size=1024m 0 0

# 卸载
umount /mnt/r


# https://blog.csdn.net/zzqhost/article/details/71307690
# https://linuxhint.com/ramdisk_ubuntu_1804/