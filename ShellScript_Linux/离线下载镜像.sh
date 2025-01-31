# 列出所有镜像
docker images
# 对镜像进行打包
docker save -o alpine.tar alpine:latest
ls -trl alpine.tar
# 镜像加载
docker load -i alpine.tar
# Loaded image: alpine:latest

# 带压缩
docker save alpine:latest | xz -z -e -9 -T 0 -v -c > alpine.tar.xz
xz -d -v -c alpine.tar.xz | docker load
