# macOS 安装 Nginx
brew install nginx
vim /usr/local/etc/nginx/nginx.conf
# 改 server { listen 端口号为 80
brew services start nginx

# macOS 安装 PHP
brew install php
cd /usr/local/etc/php/ && ls
cd <var>
vim php.ini
vim php-fpm.conf
brew services start php

vim /usr/local/etc/nginx/nginx.conf
# 添加默认首页 php
index  index.php index.html index.htm;

# 取消以下内容的注释，并做修改
location ~ \.php$ {
    fastcgi_intercept_errors on;
    fastcgi_pass   127.0.0.1:9000;
    fastcgi_index  index.php;
    fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
    include        /usr/local/etc/nginx/fastcgi_params;
}

# 路径
cd /usr/local/var/www
curl -o index.php "https://api.inn-studio.com/download/?id=xprober" # PHP探针

# ImageMagick
pecl install imagick

# 重启服务
brew services stop nginx
brew services stop php
brew services start php
brew services start nginx
