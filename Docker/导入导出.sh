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