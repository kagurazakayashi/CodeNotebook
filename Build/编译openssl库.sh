# 1. 下载zlib库 http://zlib.net/
wget http://zlib.net/zlib-1.2.13.tar.gz

# 2. 编译安装zlib库
tar -zxvf zlib-1.2.13.tar.gz
cd zlib-1.2.13
mkdir build
cd build
../configure --prefix=/usr/local
make -j`grep -c ^processor /proc/cpuinfo`
sudo make install
make clean

# 3. 下载OpenSSL
git clone https://github.com/openssl/openssl.git
cd openssl

# 5. 编译并安装
mkdir build
cd build
../config enable-shared --prefix=/usr/local/openssl/ --openssldir=/usr/local/ssl/zlib
make -j`grep -c ^processor /proc/cpuinfo`
make test  # 测试，可选，慢
sudo make install
make clean

# 6. 使用
# 在/usr/local/openssl/lib中存放的生成的openssl库libcrypto.a和libssl.a，可以直接用来参与静态编译

# https://www.cnblogs.com/jeffen/p/5993964.html

ln -s /usr/local/openssl/lib64/libssl.so.3 /usr/lib/libssl.so.3
ln -s /usr/local/openssl/lib64/libcrypto.so.3 /usr/lib/libcrypto.so.3
ln -s /usr/local/openssl/lib64/libssl.so.3 /usr/lib64/libssl.so.3
ln -s /usr/local/openssl/lib64/libcrypto.so.3 /usr/lib64/libcrypto.so.3
ln -s /usr/local/openssl/bin/openssl /usr/local/bin/openssl
ln -s /usr/local/openssl/bin/openssl /usr/bin/openssl
ln -s /usr/local/openssl/bin/c_rehash /usr/local/bin/c_rehash
openssl version


# Can't locate IPC/Cmd.pm in @INC
dnf install perl-IPC-Cmd -y
# Can't locate Pod/Html.pm in @INC
dnf install perl-CPAN -y
cpan
install Module::Build
install Net::Netmask
# 或 cpan Module::Build && cpan Net::Netmask
