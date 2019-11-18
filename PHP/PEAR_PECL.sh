# PEAR

#这是一个安装 pear 的 php 发行包文件
wget http://pear.php.net/go-pear.phar
#执行安装
php go-pear.phar

#如果想升级到最新版本
pear upgrade --force PEAR
#更新下仓库
pecl channel-update pecl.php.net

#代理
pear config-set http_proxy http://127.0.0.1:23333
#取消代理
pear config-set http_proxy ""

# PECL
yum groupinstall "Development tools"
yum -y install gcc gcc-c++  make cmake automake autoconf

# 安装扩展
pecl info redis
pecl install redis
pecl unisntall redis

#也可以使用安装包
wget http://pecl.php.net/get/redis-3.0.0.tgz
pecl install redis-3.0.0.tgz

# 就会生成 redis.so 文件，加入到 php.ini 中即可