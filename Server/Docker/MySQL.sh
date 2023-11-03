# 官方的最新版本的镜像
docker pull mysql:latest
# 指定版本
docker pull mysql:5.6
# 查看是否已安装了 mysql
docker images |grep mysql

# 运行 mysql 容器
docker run -itd --name mysql-test -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 mysql
# -p 3306:3306 ：映射容器服务的 3306 端口到宿主机的 3306 端口，外部主机可以直接通过 宿主机ip:3306 访问到 MySQL 的服务。
# MYSQL_ROOT_PASSWORD=123456：设置 MySQL 服务 root 用户的密码。

# 运行 mysql 容器 2
docker run -p 3306:3306 --name mymysql -v $PWD/conf:/etc/mysql/conf.d -v $PWD/logs:/logs -v $PWD/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -d mysql:5.6
# -p 3306:3306：将容器的 3306 端口映射到主机的 3306 端口。
# -v -v $PWD/conf:/etc/mysql/conf.d：将主机当前目录下的 conf/my.cnf 挂载到容器的 /etc/mysql/my.cnf。
# -v $PWD/logs:/logs：将主机当前目录下的 logs 目录挂载到容器的 /logs。
# -v $PWD/data:/var/lib/mysql ：将主机当前目录下的data目录挂载到容器的 /var/lib/mysql 。
# -e MYSQL_ROOT_PASSWORD=123456：初始化 root 用户的密码。

#
mkdir db && mkdir /db/conf && mkdir /db/logs && mkdir /db/data

docker run -p 3306:3306 --name mysql \
-v /db/conf:/etc/mysql/conf.d \
-v /db/logs:/logs \
-v /db/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=********* \
-d mysql:latest

# 查看容器启动情况
docker ps