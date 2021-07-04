# 先停止正在运行的docker
service docker stop
# 在其它盘中新建一个目录
mkdir /disk/docker
# 移动/var/lib/docker/目录下的所有去/disk/docker中
mv /var/lib/docker/* /disk/docker/
# 软连接/disk/docker到/var/lib/里
ln -s /disk/docker /var/lib/