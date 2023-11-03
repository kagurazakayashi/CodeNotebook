# Docker清理

# 使用 df 命令查看磁盘的使用情况：
docker system df

# 清理停止的容器：使用 docker rm 命令清理停止的容器，命令格式为：
docker rm container_id
# 清理未使用的镜像：使用 docker image prune 命令清理未使用的镜像，命令格式为：
docker image prune
# 清理无用的数据卷：使用 docker volume prune 命令清理无用的数据卷，命令格式为：
docker volume prune
# 清理未使用的网络：使用 docker network prune 命令清理未使用的网络，命令格式为：
docker network prune
# 清理Docker缓存：使用 docker builder prune 命令清理Docker缓存，命令格式为：
docker builder prune
# 清理Docker日志：使用 docker logs 命令查看容器日志，确认无用日志后，使用 truncate 命令清空日志文件，命令格式为：
truncate -s 0 logfile
# 全清
docker system prune
