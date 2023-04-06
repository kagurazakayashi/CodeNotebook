git clone https://github.com/redis/hiredis.git
cd hiredis
make
sudo make install
sudo cp ./libhiredis.so /usr/lib/libhiredis.so.1.0.1-dev
ldconfig   #使动态库在系统中更新生效

# 把 libhiredis.so 拷入文件夹，编译程序时：
gcc -o main -L./ main.c -l hiredis

# 接口介绍

# 函数原型：redisContext *redisConnect(const char *ip, int port);
# 说明：该函数用来连接redis数据库，参数为数据库的ip地址和端口，通常默认端口为6379。该函数返回一个redisContext对象。

# 函数原型：void *redisCommand(redisContext *c, const char *format, …);
# 说明：该函数执行redis命令，当然也包括由lua脚本组成的命令，返回redisReply对象。

# 函数原型void freeReplyObject(void *reply);
# 说明：释放redisCommand执行后返回的redisReply所占用的内存。

# 函数原型：void redisFree(redisContext *c);
# 说明：释放redisConnect()所产生的连接。

# https://blog.csdn.net/hyb612/article/details/78170728