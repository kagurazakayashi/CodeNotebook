# 首先创建文件并写入
vi /etc/modprobe.d/floppy-pnp.conf
# alias pnp:dPNP0700 floppy
# alias acpi:PNP0700: floppy

# 重启系统
ls /dev/fd0

mkdir /mnt/floppy
# mount -t vfat /dev/fd0 /mnt/floppy
mount /dev/fd0 /mnt/floppy
umount /mnt/floppy