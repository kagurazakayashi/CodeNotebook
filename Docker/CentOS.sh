docker run -d -i -t centos /bin/bash
docker ps -a
docker attach <ContainerID>
yum search ifconfig

/usr/sbin/sshd -D

# 常用命令
#退出，但不停止容器
Ctrl+P+Q
#回到Docker下面，停止容器
docker stop <容器ID>
#提交当前容器到镜像
docker commit <容器ID> <NAME/VERSION>
#启动新容器，并且进行端口映射
docker run -itd -p 50001:22 <刚才提交的镜像ID>  /bin/bash
#
docker run --name lnp0 -h lnp0 -p 80:9000 -v /mnt/d/w/lnp0:/d -d -i -t centos /bin/bash
docker attach lnp0