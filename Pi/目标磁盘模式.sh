# 在根目录下面的 /config.txt 文件的末尾添加一行
dtoverlay=dwc2
# 重启

# 内存盘作为目标磁盘：
mkdir -p /mnt/vram
mount tmpfs /mnt/vram -t tmpfs -o size=6192m

# 新建一个6g的镜像文件
dd if=/dev/zero of=/mnt/vram/udisk.bin bs=1000000 count=6000
# 然后格式化成 vfat 格式
mkfs.vfat /mnt/vram/udisk.bin
# 挂载虚拟硬盘文件到 USB 口：
modprobe g_mass_storage file=/mnt/vram/udisk.bin removable=1 dVendor=0x0781 idProduct=0x5572 bcdDevice=0x011a iManufacturer="SanDisk" iProduct="Cruzer Switch" iSerialNumber="1234567890"