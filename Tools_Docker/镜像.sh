# 列出本地主机上的镜像
docker images
# 从镜像运行容器/使用镜像来创建一个容器 REPOSITORY:TAG
docker run -t -i ubuntu:15.10 /bin/bash
# 拉取镜像
docker pull ubuntu:13.10
# 运行镜像
docker run httpd
# 查找镜像
docker search httpd
# 从容器新建镜像
docker commit -m="has update" -a="runoob" e218edb10161 runoob/ubuntu:v2
# 导出镜像
docker save 镜像名（或镜像ID） > 镜像名（自定义）.tar 
docker save 镜像名 | xz -z -9 -e -T 0 >file.tar.xz
# 删除镜像
# 先移除WEB应用容器
docker stop ID/名字
docker rm ID/名字
docker rmi 镜像名