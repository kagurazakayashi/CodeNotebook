cd /var/lib/docker/volumes/nginx_www/_data/ip

DOCKERIMAGE="archlinux:latest"
DOCKERSAVEF="${DOCKERIMAGE//[\/:\\]/_}"
echo "$DOCKERIMAGE" "$DOCKERSAVEF"

# 离线pull 从另一台电脑下载image
docker pull $DOCKERIMAGE
docker save $DOCKERIMAGE | nice -n 19 xz -z -1 -T 0 -v -c >$DOCKERSAVEF.tar.xz
# 清理
docker rmi $DOCKERIMAGE

# skopeo 可以直接从远程仓库下载镜像并保存为 tar 文件(不支持管道压成 xz)：
skopeo copy docker://$DOCKERIMAGE docker-archive:$DOCKERSAVEF.tar

unset DOCKERIMAGE
unset DOCKERSAVEF

# 接收
DOCKERIMAGE="archlinux:latest"
DOCKERSAVEF="${DOCKERIMAGE//[\/:\\]/_}"
curl --socks5 "192.168.1.45:23334" -o "$DOCKERSAVEF.tar.xz" "http://103.121.211.126/$DOCKERSAVEF.tar.xz"
# 导入 
xz -d -c $DOCKERSAVEF.tar.xz | docker load
