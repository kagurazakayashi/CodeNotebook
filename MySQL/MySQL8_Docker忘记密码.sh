# 进入容器
docker exec -it mysql /bin/bash

# 修改配置文件
cd /etc/mysql
vi my.cnf
#在最后添加:
# skip-grant-tables #在启mysql时不启动grant-tables

# 重启容器
docker restart mysql

# 再次进入容器，运行下面命令
mysql -u root -p
# 无需输入密码直接回车登录

# 先把root的旧密码置空
update mysql.user set authentication_string='' where user='root';

# 去除 skip-grant-tables ，重启数据库。

# 无需输入密码直接回车登录，重置成新密码：
alter mysql.user 'root'@'localhost' identified by 'newpasswordot';
# Mysql8.0之前：
update mysql.user set password=password('newpasswordot') where user='root';