# 离线pull 从另一台电脑下载image
docker save alpine:latest | nice -n 19 xz -z -e -9 -T 0 -v -c >/alpine_latest.tar.xz
# 清理
docker rmi alpine:latest

# 导入 
xz -d -c /alpine_latest.tar.xz | docker load
