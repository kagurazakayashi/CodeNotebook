yum install fuse-devel -y
# https://github.com/relan/exfat
git clone https://github.com/relan/exfat.git
cd exfat
autoreconf --install
./configure
make
sudo make install
# sudo make uninstall # 卸载

# 将设备 /dev/sdb1 挂载到 /mnt/exfat
mkdir /mnt/exfat
mount.exfat-fuse /dev/sdb1 /mnt/exfat
# 取消挂载
umount /mnt/exfat
