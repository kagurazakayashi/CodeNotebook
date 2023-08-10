# DockerNginxPHP
docker volume create nginx_www
docker volume create nginx_conf
docker volume create nginx_log
docker volume create php_conf
docker volume create php_log
mkdir -p /var/lib/docker/volumes/nginx_log/_data/nginx
docker run -d -p 80:80 -p 443:443 --name nginx --net work --ip 172.18.0.80 -e TZ=Asia/Shanghai -v nginx_www:/usr/share/nginx/html -v nginx_conf:/etc/nginx -v nginx_log:/var/log nginx:latest
docker run -d --name php --net work --ip 172.18.0.81 --cap-add SYS_PTRACE -v nginx_www:/var/www/html -v php_conf:/usr/local/etc -v php_log:/var/log/php php:8.2-fpm
