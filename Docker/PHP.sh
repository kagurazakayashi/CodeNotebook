docker search php
docker pull php
docker pull php:5.6-fpm
docker images

# Nginx + PHP 部署
# --name myphp-fpm : 将容器命名为 myphp-fpm。
# -v ~/nginx/www:/www : 将主机中项目的目录 www 挂载到容器的 /www
docker run --name myphp-fpm -v ~/nginx/www:/www -d php:5.6-fpm

# 创建 ~/nginx/conf/conf.d 目录
mkdir ~/nginx/conf/conf.d
# 在该目录下添加 ~/nginx/conf/conf.d/runoob-test-php.conf 文件
# php:9000: 表示 php-fpm 服务的 URL，下面我们会具体说明。
# /www/: 是 myphp-fpm 中 php 文件的存储路径，映射到本地的 ~/nginx/www 目录。

# 启动 nginx
docker run --name runoob-php-nginx -p 8083:80 -d \
    -v ~/nginx/www:/usr/share/nginx/html:ro \
    -v ~/nginx/conf/conf.d:/etc/nginx/conf.d:ro \
    --link myphp-fpm:php \
    nginx
# -p 8083:80: 端口映射，把 nginx 中的 80 映射到本地的 8083 端口。
# ~/nginx/www: 是本地 html 文件的存储目录，/usr/share/nginx/html 是容器内 html 文件的存储目录。
# ~/nginx/conf/conf.d: 是本地 nginx 配置文件的存储目录，/etc/nginx/conf.d 是容器内 nginx 配置文件的存储目录。
# --link myphp-fpm:php: 把 myphp-fpm 的网络并入 nginx，并通过修改 nginx 的 /etc/hosts，把域名 php 映射成 127.0.0.1，让 nginx 通过 php:9000 访问 php-fpm。

# 接下来我们在 ~/nginx/www 目录下创建 index.php
# <?php echo phpinfo(); ?>
# 浏览器打开 http://127.0.0.1:8083/index.php