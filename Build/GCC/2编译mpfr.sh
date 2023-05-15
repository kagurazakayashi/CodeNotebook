# (GNU镜像)：http://ftp.gnu.org/gnu/mpfr/ 或者官网: http://www.mpfr.org/mpfr-current/
wget https://www.mpfr.org/mpfr-current/mpfr-4.2.0.tar.xz
tar -Jxvf mpfr-4.2.0.tar.xz
cd mpfr-4.2.0
mkdir build
cd build
../configure --prefix=/usr/local/mpfr-4.2.0 --with-gmp=/usr/local/gmp-6.2.1
make -j`grep -c ^processor /proc/cpuinfo`
sudo make install
make clean
