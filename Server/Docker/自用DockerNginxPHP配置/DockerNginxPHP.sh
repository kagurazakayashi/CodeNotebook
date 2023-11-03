# DockerNginxPHP
docker volume create nginx_www
docker volume create nginx_conf
docker volume create nginx_log
docker volume create php_conf
docker volume create php_log
mkdir -p /var/lib/docker/volumes/nginx_log/_data/nginx
docker run -d -p 80:80 -p 443:443 --name nginx --net work --ip 172.18.0.80 -e TZ=Asia/Shanghai -v nginx_www:/usr/share/nginx/html -v nginx_conf:/etc/nginx -v nginx_log:/var/log nginx:latest
docker run -d --name php --net work --ip 172.18.0.81 --cap-add SYS_PTRACE -v nginx_www:/var/www/html -v php_conf:/usr/local/etc -v php_log:/var/log/php php:8.2-fpm

# DockerNginxLua
FROM alpine:latest
RUN apk add --no-cache nginx-mod-http-lua
CMD ["nginx"]

# load_module /usr/lib/nginx/modules/ndk_http_module.so;
# load_module /usr/lib/nginx/modules/ngx_http_lua_module.so;
# pcre_jit on;
# events {
#   worker_connections 1024;
# }
# daemon off;

# !/bin/bash
docker stop nginx
docker rm nginx
docker rmi nginx_alpine_lua
docker build -t nginx_alpine_lua .
docker run -d -p 80:80 -p 443:443 --name nginx --net work --ip 172.18.0.80 -e TZ=Asia/Shanghai -v nginx_www:/usr/share/nginx/html -v nginx_conf:/etc/nginx -v nginx_log:/var/log nginx_alpine_lua

# OpenResty
docker run -d -p 80:80 -p 443:443 --name openresty --net work --ip 172.18.0.80 -e TZ=Asia/Shanghai -v nginx_www:/usr/share/nginx/html -v nginx_conf:/etc/nginx -v nginx_log:/var/log openresty/openresty:alpine-apk
