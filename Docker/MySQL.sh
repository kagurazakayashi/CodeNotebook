docker pull mysql
docker pull mysql:5.6
docker images |grep mysql

# 使用mysql镜像
docker run -p 3306:3306 --name mymysql -v $PWD/conf:/etc/mysql/conf.d -v $PWD/logs:/logs -v $PWD/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -d mysql:5.6
# -p 3306:3306：将容器的 3306 端口映射到主机的 3306 端口。
# -v -v $PWD/conf:/etc/mysql/conf.d：将主机当前目录下的 conf/my.cnf 挂载到容器的 /etc/mysql/my.cnf。
# -v $PWD/logs:/logs：将主机当前目录下的 logs 目录挂载到容器的 /logs。
# -v $PWD/data:/var/lib/mysql ：将主机当前目录下的data目录挂载到容器的 /var/lib/mysql 。
# -e MYSQL_ROOT_PASSWORD=123456：初始化 root 用户的密码。

# 查看容器启动情况
docker ps