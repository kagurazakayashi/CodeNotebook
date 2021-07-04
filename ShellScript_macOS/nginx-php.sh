brew install nginx
brew services start nginx
brew install php
brew services start php
cd /usr/local/etc/php/ && ls
cd <var>
vim php.ini
vim php-fpm.conf

vim /usr/local/etc/nginx/nginx.conf

# 添加默认首页 php
    index  index.php index.html index.htm;
    
# 取消以下内容的注释，并做修改
location ~ \.php$ {
    fastcgi_intercept_errors on;
    fastcgi_pass   127.0.0.1:9000;
    fastcgi_index  index.php;
    fastcgi_param  SCRIPT_FILENAME  /usr/local/Cellar/nginx/<var>/html$fastcgi_script_name;
    include        /usr/local/etc/nginx/fastcgi_params;
}

# 路径
/usr/local/var/www

# ImageMagick
pecl install imagick

brew services stop php
brew services stop nginx
brew services start nginx
brew services start php