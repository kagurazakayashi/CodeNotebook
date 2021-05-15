# 1.    下载zlib库
wget http://zlib.net/zlib-1.2.11.tar.gz

# 2.    编译安装zlib库
cd /home
tar -zxvf zlib-1.2.11.tar.gz
cd zlib-1.2.11
./configure --prefix=/usr/local
make
sudo make install
make clean

# 3.    下载OpenSSL
git clone https://github.com/openssl/openssl.git
cd openssl

# 5.    编译并安装
./config enable-shared --prefix=/usr/local/openssl/ --openssldir=/usr/local/ssl/zlib
make       # 慢，可用 -j线程
make test  # 测试，慢
sudo make install
make clean

# 6.    使用
# 在/usr/local/openssl/lib中存放的生成的openssl库libcrypto.a和libssl.a，可以直接用来参与静态编译

# https://www.cnblogs.com/jeffen/p/5993964.html