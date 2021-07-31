# volume 的目录一般在 /var/lib/docker/volumes/<volume-name>下。
docker volume create datavolume
# 创建容器时挂载这个虚拟盘
docker run -v datavolume:/data
# 列出文件
ls /var/lib/docker/volumes/datavolume
# volume 列表
docker volume ls
# 查看指定卷的详细信息
docker volume inspect my_vol
# 删除卷
docker volume rm my_vol
# 挂载情况
docker inspect datavolume
# 只读模式挂载
docker run -d --mount source=nginx-vol,destination=/usr/share/nginx/html,readonly
# 删除所有未使用的虚拟盘
docker volume prune
# 内存盘
docker run --mount type=tmpfs,destination=/usr/share/nginx/html
# 同时指定权限
docker run --mount type=tmpfs,destination=/usr/share/nginx/html,tmpfs-mode=1770