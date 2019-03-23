# 安装
> choco install redis-64 -y

Chocolatey v0.10.11
Installing the following packages:
redis-64
By installing you accept licenses for the packages.
Progress: Downloading redis-64 3.0.503... 100%

redis-64 v3.0.503 [Approved]
redis-64 package files install completed. Performing other installation steps.
 ShimGen has successfully created a shim for redis-benchmark.exe
 ShimGen has successfully created a shim for redis-check-aof.exe
 ShimGen has successfully created a shim for redis-check-dump.exe
 ShimGen has successfully created a shim for redis-cli.exe
 ShimGen has successfully created a shim for redis-server.exe
 The install of redis-64 was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

Chocolatey installed 1/1 packages.
 See the log for details (C:\ProgramData\chocolatey\logs\chocolatey.log).

C:\ProgramData\chocolatey\lib\redis-64\

# 启动服务器
> redis-server

# 启动命令行
> redis-cli

## 测试
127.0.0.1:6379> set test hahaha
OK
127.0.0.1:6379> get test
"hahaha"
127.0.0.1:6379> exit

# 配置参数
notepad "C:\ProgramData\chocolatey\lib\redis-64\redis.windows-service.conf"
bind 127.0.0.1
dbfilename redis_dump.rdb
dir C:\redisdb
logfile redis.log
requirepass <512PWD>

> net stop redis && net start redis

# 注册为 Windows 服务
> redis-server.exe --service-install redis.windows-service.conf
> net start redis

卸载服务：redis-server --service-uninstall
开启服务：redis-server --service-start
停止服务：redis-server --service-stop
重命名服务：redis-server --service-name name

# 安装到 PHP

[下载igbinary](https://pecl.php.net/package/igbinary)
copy php_igbinary.dll C:\php\ext\
copy php_igbinary.pdb C:\php\ext\

[下载redis](https://pecl.php.net/package/redis)
copy php_redis.dll C:\php\ext\
copy php_redis.pdb C:\php\ext\

## php.ini
extension=php_igbinary.dll
extension=php_redis.dll
