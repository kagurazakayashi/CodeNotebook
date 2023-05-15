# http://ftp.gnu.org/gnu/mpc/
wget http://ftp.gnu.org/gnu/mpc/mpc-1.3.1.tar.gz
tar -xvzf mpc-1.3.1.tar.gz
cd mpc-1.3.1
mkdir build
cd build
../configure --prefix=/usr/local/mpc-1.3.1 --with-gmp=/usr/local/gmp-6.2.1 --with-mpfr=/usr/local/mpfr-4.2.0
make -j`grep -c ^processor /proc/cpuinfo`
sudo make install
make clean
