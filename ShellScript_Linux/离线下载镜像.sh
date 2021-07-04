# 列出所有镜像
docker images
# 对镜像进行打包
docker save -o mysql.tar mysql:latest
ls -trl mysql.tar
# 镜像加载
docker load -i mysql.tar
# Loaded image: mysql:latest