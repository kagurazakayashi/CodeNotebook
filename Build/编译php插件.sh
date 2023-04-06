tar -jxvf php-7.2.13.tar.bz2
cd php-7.2.13/ext/fileinfo
phpize
./configure --with-php-config=/usr/local/php/bin/php-config
# /usr/local/php/lib/php/extensions/no-debug-non-zts-20170718/fileinfo
