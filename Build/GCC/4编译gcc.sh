vim /etc/profile #：
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/mpc-1.3.1/lib:/usr/local/gmp-6.2.1/lib:/usr/local/mpfr-4.2.0/lib
source /etc/profile

# https://gcc.gnu.org/mirrors.html

wget https://mirrors.aliyun.com/gnu/gcc/gcc-13.1.0/gcc-13.1.0.tar.xz
tar -Jxvf gcc-13.1.0.tar.xz
cd gcc-13.1.0
mkdir build
cd build
# --enable-languages=all, default, ada, c, c++, d, fortran, go, jit, lto, m2, objc, obj-c++
../configure --disable-multilib --enable-languages=c,c++ --with-gmp=/usr/local/gmp-6.2.1 --with-mpfr=/usr/local/mpfr-4.2.0 --with-mpc=/usr/local/mpc-1.3.1
make -j`grep -c ^processor /proc/cpuinfo` # 需要很久
sudo make install
ls /usr/local/bin | grep gcc
gcc -v

# 检查动态库
strings /usr/lib64/libstdc++.so.6 | grep GLIBC
ls -ahl /usr/local/lib64/libstd*.so.*
cd /usr/lib64/
cp /usr/local/lib64/libstdc++.so.6.0.31 ./
rm libstdc++.so.6
ln -s libstdc++.so.6.0.31 libstdc++.so.6
strings /usr/lib64/libstdc++.so.6 | grep GLIBC

where gcc
rm /usr/bin/gcc
ln -s /usr/local/bin/gcc /usr/bin/gcc

make clean
