# 找到要修改容器的 CONTAINER ID
docker ps -a
docker inspect 【CONTAINER ID】 | grep Id
# 找到与 Id 相同的目录
# 设置的 docker 数据文件夹 /containers
cd /var/lib/docker/containers
# 停止 docker 引擎服务
systemctl stop docker
service docker stop
# 进入对应 Id 所在目录
cd <id>

vim hostconfig.json
# "PortBindings":{"80/tcp":[{"HostIp":"","HostPort":"9000"}]}

vim config.v2.json
# "ExposedPorts":{"80/tcp":{"9000/tcp"}}

# 保存之后
systemctl start docker