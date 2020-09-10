# 门罗币钱包 CLI 版
curl https://downloads.getmonero.org/cli/linux64 -o monero.tar.bz2
tar -xjvf monero.tar.bz2
mv monero-x86_64-linux-gnu-v0.16.0.3 monero
cd monero
./monerod # 可能要求指定版本 glibc

# linux下编译安装 glibc
yum -y install bison
wget http://ftp.gnu.org/gnu/glibc/glibc-2.23.tar.gz
tar -zxf glibc-2.23.tar.gz
mkdir glibc-build
cd glibc-build
../glibc-2.23/configure --prefix=/usr/lib64/glibc-2.23
make
make install
mv /lib64/libm.so.6 /lib64/libm.so.6.bak # yum可能会运行异常
ln -s math/libm.so.6 /lib64/libm.so.6    # yum可能会运行异常

cp /i/glibc-build/math/libm.so.6 ~/monero
./monerod

# 挖矿
xmrig.exe -o xmr.f2pool.com:13531 -u wallet_address.m9f6gq6d12jv8wj -p x -k
# https://f2pool.io/mining/guides/how-to-mine-monero/
# http://www.bit-king.net/h-nd-53.html