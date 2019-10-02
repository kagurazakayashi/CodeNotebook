# 后台
Ctrl + P + Q
# 启动
docker start ID/名字
# 运行状况
docker stats
# 拉取镜像
docker pull training/webapp
# 创建和启动容器
# -d:让容器在后台运行。
# -P:将容器内部使用的网络端口映射到我们使用的主机上。
docker run -d -P training/webapp python app.py
# 查看容器列表
docker ps -a
# 调整端口映射
docker run -d -p 5000:5000 training/webapp python app.py
# 查看端口映射状态
docker port ID/名字
# 查看容器内部的标准输出
# -f: 让 docker logs 像使用 tail -f 一样来输出容器内部的标准输出。
docker logs -f ID/名字
# 查看容器内部运行的进程
docker top ID/名字
# 查看 Docker 的底层信息。它会返回一个 JSON 文件记录着 Docker 容器的配置和状态信息。
docker inspect ID/名字
# 停止/重启WEB应用容器
docker start ID/名字
docker stop ID/名字
# 查询最后一次创建的容器
docker ps -l
# 移除WEB应用容器
docker stop ID/名字
docker rm ID/名字
# 解除被锁定的文件
chattr -i <file>