# 缺少GD库导致宝塔面板Nginx安装失败的解决方案
yum install gd-devel gd -y
apt install libgd2-dev -y
apt install libgd2-xpm-dev -y
# RHEL8
rpm -qa|grep gd
rpm -ql gd-2.2.5-6.el8.x86_64
ln -s /usr/lib64/libgd.so.3 /usr/local/libgd.so.3
ln -s /usr/lib64/libgd.so.3.0.5 /usr/local/libgd.so.3.0.5
# 所有库
yum install make cmake gcc gcc-c++ gcc-g77 flex bison file libtool libtool-libs autoconf kernel-devel patch wget libjpeg libjpeg-devel libpng libpng-devel libpng10 libpng10-devel gd gd-devel libxml2 libxml2-devel zlib zlib-devel glib2 glib2-devel tar bzip2 bzip2-devel libevent libevent-devel ncurses ncurses-devel curl curl-devel libcurl libcurl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel libidn libidn-devel openssl openssl-devel vim-minimal gettext gettext-devel ncurses-devel gmp-devel pspell-devel libcap diffutils ca-certificates net-tools libc-client-devel psmisc libXpm-devel git-core c-ares-devel libicu-devel libxslt libxslt-devel zip unzip glibc.i686 libstdc++.so.6 cairo-devel bison-devel ncurses-devel libaio-devel perl perl-devel perl-Data-Dumper lsof pcre pcre-devel vixie-cron crontabs expat-devel readline-devel -y
yum install yum-utils -y
package-cleanup --cleandupes

# 宝塔linux面板命令大全
# 安装宝塔
# Centos安装脚本
yum install -y wget && wget -O install.sh http://download.bt.cn/install/install.sh && sh install.sh
# Ubuntu/Deepin安装脚本
wget -O install.sh http://download.bt.cn/install/install-ubuntu.sh && sudo bash install.sh
# Debian安装脚本
wget -O install.sh http://download.bt.cn/install/install-ubuntu.sh && bash install.sh
# Fedora安装脚本
wget -O install.sh http://download.bt.cn/install/install.sh && bash install.sh

# 管理宝塔
# 停止
/etc/init.d/bt stop
# 启动
/etc/init.d/bt start
# 重启
/etc/init.d/bt restart
# 卸载
/etc/init.d/bt stop && chkconfig --del bt && rm -f /etc/init.d/bt && rm -rf /www/server/panel
# 查看当前面板端口
cat /www/server/panel/data/port.pl
# 修改面板端口，如要改成8881（centos 6 系统）
echo '8881' > /www/server/panel/data/port.pl && /etc/init.d/bt restart
iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport 8881 -j ACCEPT
service iptables save
service iptables restart
# 修改面板端口，如要改成8881（centos 7 系统）
echo '8881' > /www/server/panel/data/port.pl && /etc/init.d/bt restart
firewall-cmd --permanent --zone=public --add-port=8881/tcp
firewall-cmd --reload
# 强制修改MySQL管理(root)密码，如要改成123456
cd /www/server/panel && python tools.py root 123456
# 修改面板密码，如要改成123456
cd /www/server/panel && python tools.py panel 123456
# 查看宝塔日志
cat /tmp/panelBoot.pl
# 查看软件安装日志
cat /tmp/panelExec.log
# 站点配置文件位置
/www/server/panel/vhost
# 删除域名绑定面板
rm -f /www/server/panel/data/domain.conf
# 清理登陆限制
rm -f /www/server/panel/data/*.login
# 查看面板授权IP
cat /www/server/panel/data/limitip.conf
# 关闭访问限制
rm -f /www/server/panel/data/limitip.conf
# 查看许可域名
cat /www/server/panel/data/domain.conf
# 关闭面板SSL
rm -f /www/server/panel/data/ssl.pl && /etc/init.d/bt restart
# 查看面板错误日志
cat /tmp/panelBoot
# 查看数据库错误日志
cat /www/server/data/*.err
# 站点配置文件目录(nginx)
/www/server/panel/vhost/nginx
# 站点配置文件目录(apache)
/www/server/panel/vhost/apache
# 站点默认目录
/www/wwwroot
# 数据库备份目录
/www/backup/database
# 站点备份目录
/www/backup/site
# 站点日志
/www/wwwlogs

# Nginx服务管理
# nginx安装目录
/www/server/nginx
# 启动
/etc/init.d/nginx start
# 停止
/etc/init.d/nginx stop
# 重启
/etc/init.d/nginx restart
# 启载
/etc/init.d/nginx reload
# nginx配置文件
/www/server/nginx/conf/nginx.conf

# Apache服务管理
# apache安装目录
/www/server/httpd
# 启动
/etc/init.d/httpd start
# 停止
/etc/init.d/httpd stop
# 重启
/etc/init.d/httpd restart
# 启载
/etc/init.d/httpd reload
# apache配置文件
/www/server/apache/conf/httpd.conf

# MySQL服务管理
# mysql安装目录
/www/server/mysql
# phpmyadmin安装目录
/www/server/phpmyadmin
# 数据存储目录
/www/server/data
# 启动
/etc/init.d/mysqld start
# 停止
/etc/init.d/mysqld stop
# 重启
/etc/init.d/mysqld restart
# 启载
/etc/init.d/mysqld reload
# mysql配置文件
/etc/my.cnf

# FTP服务管理
# ftp安装目录
/www/server/pure-ftpd
# 启动
/etc/init.d/pure-ftpd start
# 停止
/etc/init.d/pure-ftpd stop
# 重启
/etc/init.d/pure-ftpd restart
# ftp配置文件
/www/server/pure-ftpd/etc/pure-ftpd.conf

# PHP服务管理
# php安装目录
/www/server/php
# 启动(请根据安装PHP版本号做更改，例如：/etc/init.d/php-fpm-54 start)
/etc/init.d/php-fpm-{52|53|54|55|56|70|71} start
# 停止(请根据安装PHP版本号做更改，例如：/etc/init.d/php-fpm-54 stop)
/etc/init.d/php-fpm-{52|53|54|55|56|70|71} stop
# 重启(请根据安装PHP版本号做更改，例如：/etc/init.d/php-fpm-54 restart)
/etc/init.d/php-fpm-{52|53|54|55|56|70|71} restart
# 启载(请根据安装PHP版本号做更改，例如：/etc/init.d/php-fpm-54 reload)
/etc/init.d/php-fpm-{52|53|54|55|56|70|71} reload
# 配置文件(请根据安装PHP版本号做更改，例如：/www/server/php/52/etc/php.ini)
/www/server/php/{52|53|54|55|56|70|71}/etc/php.ini

# Redis服务管理
# redis安装目录
/www/server/redis
# 启动
/etc/init.d/redis start
# 停止
/etc/init.d/redis stop
# redis配置文件
/www/server/redis/redis.conf

# Memcached服务管理
# memcached安装目录
/usr/local/memcached
# 启动
/etc/init.d/memcached start
# 停止
/etc/init.d/memcached stop
# 重启
/etc/init.d/memcached restart
# 启载
/etc/init.d/memcached reload