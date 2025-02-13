# 离线pull 从另一台电脑下载image
docker save alpine:latest | nice -n 19 xz -z -e -9 -T 0 -v -c >/alpine_latest.tar.xz
# 清理
docker rmi alpine:latest

# 导入 
xz -d -c /alpine_latest.tar.xz | docker load

# skopeo 可以直接从远程仓库下载镜像并保存为 tar 文件(不支持管道压成 xz)：
skopeo copy docker://alpine:latest docker-archive:alpine_latest.tar
