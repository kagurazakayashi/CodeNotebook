# 查看状态
docker ps
# 创建容器时网络端口映射
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

# 登入控制台
docker exec -ti <ContainerID> bash
docker attach <ContainerID>
# 转到后台
Ctrl + P + Q