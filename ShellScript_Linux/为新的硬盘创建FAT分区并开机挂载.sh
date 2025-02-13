# Alpine 为新的硬盘创建 FAT32 分区并开机挂载
# 假设新的硬盘设备是 /dev/sdb

# 查看当前系统已识别的硬盘：
fdisk -l

# 创建分区
fdisk /dev/sdb
# 在 fdisk 交互界面中：
# 输入 n 创建新分区。
# 选择 p（主分区）。
# 选择分区编号（默认 1）。
# 直接按 Enter 选择默认的起始扇区和结束扇区（使用整个磁盘）。
# 输入 t 更改分区类型，输入 L 列出支持的分区类型列表。
# 输入 w 保存更改并退出。

# 格式化为 FAT32
mkfs.vfat -F 32 /dev/sdb1
# 格式化为 FAT16
mkfs.vfat -F 16 /dev/sdb1
# 如果需要卷标（LABEL），可以使用：
mkfs.vfat -F 32 -n MYDISK /dev/sdb1

# 创建挂载点
mkdir -p /mnt/d

# 手动挂载
mount -t vfat /dev/sdb1 /mnt/d
# 如果需要读写权限，可以加上 umask=000 选项：
mount -t vfat -o rw,umask=000 /dev/sdb1 /mnt/d
# 检查是否挂载成功
df -h

# 开机自动挂载
# 编辑 /etc/fstab 文件
vi /etc/fstab
# 在文件末尾添加以下内容
# /dev/sdb1  /mnt/d  vfat  defaults,umask=000  0  0
# 保存退出。

# 然后运行
mount -a
# 确保没有错误，重启
reboot
