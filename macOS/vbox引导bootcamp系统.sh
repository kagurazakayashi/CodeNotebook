# 关闭SIP
# 列出系统中挂载的磁盘
diskutil list

#-  #:                  TYPE NAME             SIZE     IDENTIFIER
#-  0: GUID_partition_scheme                 *500.3 GB disk0
#!  1:                   EFI EFI              314.6 MB disk0s1
#-  2:            Apple_APFS Container disk1  371.0 GB disk0s2
#!  3:  Microsoft Basic Data BOOTCAMP         129.0 GB disk0s3

# 每次重启都需要重新运行以下命令

# 取消挂载 Boot Camp 磁盘
diskutil unmount /Volumes/BOOTCAMP
# 设置磁盘权限以使 VirtualBox 可读写它们
sudo chmod 777 /dev/disk0s1  # EFI 磁盘的磁盘号
sudo chmod 777 /dev/disk0s3  # BOOTCAMP 磁盘的磁盘号
# 新系统设置磁盘信息权限
sudo chown yashi /dev/disk0*
sudo chmod 777 /dev/disk0

# 创建虚拟机镜像
sudo VBoxManage internalcommands createrawvmdk -rawdisk /dev/disk0 -filename ~/bootcamp.vmdk -partitions 【EFI磁盘号】,【BOOTCAMP磁盘号】
sudo chown【你的用户名】 *.vmdk

sudo VBoxManage internalcommands createrawvmdk -rawdisk /dev/disk0 -filename ~/bootcamp.vmdk -partitions 1,3
sudo chown yashi *.vmdk

# VirtualBox 设置
# 选择使用已有的虚拟硬盘文件,SATA
# 启用 I/O APIC、启用 EFI
# 设置-系统-处理器-拓展特性-启用 PAE/NX
# 设置-显示-屏幕-硬件加速-启用 3D 和 2D 加速
# 设置-存储-属性-使用主机输入输出(I/O)缓存

# https://ladit.me/posts/using-virtualbox-to-run-boot-camp/

# 挂载 U 盘
diskutil list

rm -f ~/*.vmdk && diskutil unmountDisk /dev/disk5 && sudo chown $(whoami) /dev/disk5 && VBoxManage internalcommands createrawvmdk -filename ~/usb.vmdk -rawdisk /dev/disk5

rm -f ~/*.vmdk