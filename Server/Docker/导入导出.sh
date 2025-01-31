# 备份与迁移

# 容器保存为镜像
# 我们可以通过以下命令将容器保存为镜像
docker commit pyg_nginx mynginx
# pyg_nginx是容器名称
# mynginx是新的镜像名称
# 此镜像的内容就是你当前容器的内容，接下来你可以用此镜像再次运行新的容器

# 镜像备份
docker save -o mynginx.tar mynginx
# -o 输出到的文件
# 执行后，运行ls命令即可看到打成的tar包
# 压缩导出
docker save mynginx | xz -z -e -9 -T 0 -v -c >mynginx.tar.xz

# 镜像恢复与迁移
# 首先我们先删除掉mynginx镜像
# 然后执行此命令进行恢复
docker load -i mynginx.tar
# -i 输入的文件
# 执行后再次查看镜像，可以看到镜像已经恢复

docker container ls -a
# 1、导出容器
# 导出容器可以导出一个已经创建的容器到一个文件，不管容器处于什么状态，可以使用docker export 命令。
# 命令格式为：docker export [-o|--output[=""]] CONTATINER
# docker export -o 打包.tar 容器名
docker export -o backup.tar lnp0
# 可以使用scp 指令将文件进行传送：
scp backup.tar root@192.168.2.33:/root/

# 2、导入容器
# 导入的文件可以使用docker import 命令导入变成镜像，该命令的格式为：
# docker import [-c|--change[=[]]] [-m|--message[=MESSAGE]] file|URL|-[REPOSITORY[:YAG]]
docker import backup.tar lnp0
docker images

# 压缩导入
xz -d -v -c mynginx.tar.xz | docker load
