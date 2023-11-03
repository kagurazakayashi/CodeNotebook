# 创建容器时网络端口映射
# -p 主机:容器

# 将容器暴露的所有端口，都随机映射到宿主机上
docker run -P -it ubuntu /bin/bash
# 将容器指定端口随机映射到宿主机一个端口上
docker run -P 80 -it ubuntu /bin/bash
# 将容器指定端口指定映射到宿主机的一个端口上（容器端口80，宿主机端口8000）
docker run -p 8000:80 -it ubuntu /bin/bash
# 将容器ip和端口，指定映射到宿主机上
docker run -P 192.168.0.100::80 -it ubuntu /bin/bash
# 将容器ip和端口，指定映射到宿主机上
docker run -p 192.168.0.100:8000:80 -it ubuntu /bin/bash
# 查看映射端口配置
docker port container_ID #容器ID
#输出 80/tcp -> 0.0.0.0:8000

# -P :是容器内部端口随机映射到主机的高端口。
# -p : 是容器内部端口绑定到指定的主机端口。
docker run -d -P training/webapp python app.py
docker run -d -p 5000:5000 training/webapp python app.py
# 绑定 127.0.0.1
docker run -d -p 127.0.0.1:5001:5000 training/webapp python app.py
# 绑定 UDP
docker run -d -p 127.0.0.1:5000:5000/udp training/webapp python app.py
# 快捷地查看端口的绑定情况
docker port ID/名字 5000
# 容器命名
docker run -d -P --name runoob training/webapp python app.py

# 直接修改已有的

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