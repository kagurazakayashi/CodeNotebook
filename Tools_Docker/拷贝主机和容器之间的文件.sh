# 从容器拷贝文件到宿主机
# docker cp 容器名mycontainer:容器中要拷贝的文件名及其路径/opt/testnew/file.txt 要拷贝到宿主机里面对应的路径:/opt/test/
docker cp mycontainer:/opt/testnew/file.txt /opt/test/

# 从宿主机拷贝文件到容器
# docker cp 宿主机中要拷贝的文件名及其路径/opt/test/file.txt 容器名mycontainer:要拷贝到容器里面对应的路径/opt/testnew/
docker cp /opt/test/file.txt mycontainer:/opt/testnew/

# 不管容器有没有启动，拷贝命令都会生效