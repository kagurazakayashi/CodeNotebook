# Docker清理

# 仅清理未使用的缓存和构建数据：这个命令会清理构建过程中产生的缓存。
docker builder prune

# 全面清理未使用的数据：这个命令会删除未使用的容器、镜像、网络和缓存。
docker system prune

# 全面清理，包括停止的容器和未挂载的卷：这个命令会删除所有未被容器使用的镜像，以及所有停止的容器、未使用的网络和未挂载的卷。
docker system prune -a

# 在构建时禁用缓存: --no-cache
docker build --no-cache -t your_image_name .

# 手动清理特定缓存: 可以结合 docker builder prune 命令的选项：
# 这个命令会删除过去 24 小时未使用的构建缓存:
docker builder prune --filter "until=24h"

# 查看缓存占用空间: 使用 df 命令查看磁盘的使用情况：
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
