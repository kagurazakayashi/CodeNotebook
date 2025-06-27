DOCKERIMAGE="alpine:latest"
DOCKERSAVEF="${DOCKERIMAGE//[\/:\\]/_}"
echo "$DOCKERIMAGE" "$DOCKERSAVEF"

# 离线pull 从另一台电脑下载image
docker save $DOCKERIMAGE | nice -n 19 xz -z -e -9 -T 0 -v -c >$DOCKERSAVEF.tar.xz
# 清理
docker rmi $DOCKERIMAGE

# 导入 
xz -d -c $DOCKERSAVEF.tar.xz | docker load

# skopeo 可以直接从远程仓库下载镜像并保存为 tar 文件(不支持管道压成 xz)：
skopeo copy docker://$DOCKERIMAGE docker-archive:$DOCKERSAVEF.tar

unset DOCKERIMAGE
unset DOCKERSAVEF
