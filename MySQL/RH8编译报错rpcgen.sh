# 在Centos8系统编译mysql5.7.27时报错，报错内容如下：

# CMake Error at rapid/plugin/group_replication/rpcgen.cmake:93 (MESSAGE):
#   Could not find rpcgen
# Call Stack (most recent call first):
#   rapid/plugin/group_replication/CMakeLists.txt:29 (INCLUDE)

# 提示找不到rpcgen，yum源中也没有这个包，解决办法：
# https://github.com/thkukuk/rpcsvc-proto/releases

wget https://github.com/thkukuk/rpcsvc-proto/releases/download/v1.4/rpcsvc-proto-1.4.tar.gz
tar xf rpcsvc-proto-1.4.tar.gz
cd rpcsvc-proto-1.4
./configure
make
make install