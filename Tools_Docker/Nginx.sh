# 查找 Docker Hub 上的 nginx 镜像
# https://hub.docker.com/r/library/nginx/
docker search nginx
# 拉取官方的镜像
docker pull nginx
# 等待下载完成后，我们就可以在本地镜像列表里查到 REPOSITORY 为 nginx 的镜像。
docker images nginx
# 使用 NGINX 默认的配置来启动一个 Nginx 容器实例
# runoob-nginx-test 容器名称。
# the -d设置容器在在后台一直运行。
# the -p 端口进行映射，将本地 8081 端口映射到容器内部的 80 端口。
docker run --name runoob-nginx-test -p 8081:80 -d nginx
# 执行以上命令会生成一串字符串，类似 6dd4380ba70820bd2acc55ed2b326dd8c0ac7c93f68f0067daecad82aef5f938，这个表示容器的 ID，一般可作为日志的文件名。
# 我们可以使用 docker ps 命令查看容器是否有在运行。PORTS 部分表示端口映射，本地的 8081 端口映射到容器内部的 80 端口。
# 在浏览器中打开 http://127.0.0.1:8081/

# nginx 部署
# 创建目录 nginx, 用于存放后面的相关东西。
mkdir -p ~/nginx/www ~/nginx/logs ~/nginx/conf
# 拷贝容器内 Nginx 默认配置文件到本地当前目录下的 conf 目录，容器 ID 可以查看 docker ps 命令输入中的第一列
docker cp 6dd4380ba708:/etc/nginx/nginx.conf ~/nginx/conf
# www: 目录将映射为 nginx 容器配置的虚拟目录。
# logs: 目录将映射为 nginx 容器的日志目录。
# conf: 目录里的配置文件将映射为 nginx 容器的配置文件。

# 部署命令
docker run -d -p 8082:80 --name runoob-nginx-test-web -v ~/nginx/www:/usr/share/nginx/html -v ~/nginx/conf/nginx.conf:/etc/nginx/nginx.conf -v ~/nginx/logs:/var/log/nginx nginx
# -p 8082:80： 将容器的 80 端口映射到主机的 8082 端口。
# --name runoob-nginx-test-web：将容器命名为 runoob-nginx-test-web。
# -v ~/nginx/www:/usr/share/nginx/html：将我们自己创建的 www 目录挂载到容器的 /usr/share/nginx/html。
# -v ~/nginx/conf/nginx.conf:/etc/nginx/nginx.conf：将我们自己创建的 nginx.conf 挂载到容器的 /etc/nginx/nginx.conf。
# -v ~/nginx/logs:/var/log/nginx：将我们自己创建的 logs 挂载到容器的 /var/log/nginx。

# 启动以上命令后进入 ~/nginx/www 目录
cd ~/nginx/www
# 创建 index.html 文件

# 如果要重新载入 NGINX 可以使用以下命令发送 HUP 信号到容器
docker kill -s HUP container-name
# 重启 NGINX 容器命令
docker restart container-name