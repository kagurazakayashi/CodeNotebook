# 免编译
# apt install fuse-exfat exfat-utils -y

apt install fuse-devel autoconf automake libtool pkg-config fuse -y
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

# configure: line 4101: syntax error near unexpected token `UBLIO,' .
wget -P m4 https://raw.githubusercontent.com/irungentoo/toxcore/master/m4/pkg.m4
echo "AC_CONFIG_MACRO_DIR([m4])" >> configure.ac
aclocal -I m4
autoreconf -i -f
./configure
make
sudo make install

# No package 'fuse' found:
git clone https://github.com/libfuse/libfuse.git
cd libfuse
apt install meson ninja -y
mkdir build
cd build
meson setup ..
ninja
cd lib
cp libfuse3.so.3.14.1 /usr/lib/libfuse3.so
export FUSE_CFLAGS=-lfuse3
export FUSE_LIBS=/usr/lib/libfuse3.so
cd ..
cd ..
cd ..
autoreconf --install
./configure
make
sudo make install
