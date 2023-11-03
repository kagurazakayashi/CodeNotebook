wget https://github.com/phpredis/phpredis/archive/4.3.0.zip
unzip 4.3.0.zip
cd phpredis-4.3.0
phpize
./configure --with-php-config=/usr/local/php/bin/php-config
make
make install
# Installing shared extensions:     /usr/local/php/lib/php/extensions/no-debug-non-zts-20180731/
vim /usr/local/php/etc/php.ini
# extension_dir = "/usr/local/php/lib/php/extensions/no-debug-non-zts-20180731"
# extension=redis.so

# 一键
pecl channel-update pecl.php.net
pecl install redis