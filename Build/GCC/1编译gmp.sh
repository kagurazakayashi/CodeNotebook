# http://ftp.gnu.org/gnu/gmp/
wget http://ftp.gnu.org/gnu/gmp/gmp-6.2.1.tar.xz
tar -Jxvf gmp-6.2.1.tar.xz
cd gmp-6.2.1
mkdir build
cd build
../configure --prefix=/usr/local/gmp-6.2.1
make -j`grep -c ^processor /proc/cpuinfo`
sudo make install
make clean
