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

# 删除镜像
# 先移除WEB应用容器
docker stop ID/名字
docker rm ID/名字
docker rmi 镜像名