# 检查docker容器中的nginx配置文件

# 确认你的 Docker 容器是运行状态，可以通过以下命令检查：
docker ps

# 验证 Nginx 配置文件
docker exec <container_id_or_name> nginx -t -c /etc/nginx/nginx.conf
docker exec nginx nginx -t

# 重新加载 Nginx 配置文件
docker exec <container_id_or_name> nginx -s reload -c /etc/nginx/nginx.conf
docker exec nginx nginx -s reload
