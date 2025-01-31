# 列出所有用户
sql> SELECT User, Host FROM mysql.user;

# ERROR 1142 (42000): SELECT command denied to user 'root'@'localhost' for table 'user'

# 确认 root 用户权限。输出的结果会显示 root 用户的权限。如果没有 mysql 数据库相关的权限，需要修改权限。
sql> SHOW GRANTS FOR CURRENT_USER;

# 以安全模式启动 MySQL

# 停止 MySQL 服务
sudo systemctl stop mysql
# 启动 MySQL，跳过权限表
sudo mysqld_safe --skip-grant-tables &
# 使用无密码方式登录 MySQL
mysql -u root
# 检查 root 用户权限是否被误删：
sql> SELECT User, Host, Grant_priv, Super_priv FROM mysql.user WHERE User = 'root';
# 为 root 用户授予所有权限：
sql> GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
sql> GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
sql> FLUSH PRIVILEGES;
sql> EXIT;
# 停止 MySQL 服务并以正常模式重新启动：
sudo systemctl stop mysql
sudo systemctl start mysql
mysql -u root -p
# 验证是否能够访问 mysql.user：
sql> SELECT User, Host FROM mysql.user;
# 在完成修复后，检查 root 用户是否有过于宽松的访问限制（如允许从任意主机 % 登录）。如果不需要远程访问，可限制到 localhost：
sql> DELETE FROM mysql.user WHERE User = 'root' AND Host != 'localhost';
sql> FLUSH PRIVILEGES;

# Docker
# 停止当前容器：
docker stop <container_name>
# 重新启动容器，带上跳过权限表的参数： 在启动容器时，修改 MySQL 的启动命令以跳过权限表检查：
docker run --name <container_name> -v /path/to/mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=<your_password> -d mysql --skip-grant-tables
# 进入容器并登录 MySQL：
docker exec -it <container_name> mysql
# 修复权限（与之前步骤一致）：
sql> UPDATE mysql.user SET Grant_priv = 'Y', Super_priv = 'Y' WHERE User = 'root';
sql> GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
sql> FLUSH PRIVILEGES;
# 退出容器并重新启动：
docker stop <container_name>
docker start <container_name>
# 避免长期运行带有 --skip-grant-tables 参数的容器，修复权限后尽快恢复正常模式。

# docker-compose
# 修改 docker-compose.yml 文件, 添加 command: --skip-grant-tables 来以跳过权限表的模式启动 MySQL。
# 重启 MySQL 容器: 在 docker-compose.yml 文件目录下，运行以下命令重新启动 MySQL 服务：
docker-compose down
docker-compose up -d
# 进入容器并登录 MySQL：
docker exec -it my_mysql mysql
# 执行以下 SQL 来修复 root 用户的权限：
sql> UPDATE mysql.user SET Grant_priv = 'Y', Super_priv = 'Y' WHERE User = 'root';
sql> GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
sql> GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
sql> FLUSH PRIVILEGES;
# 完成权限修复后，回到 docker-compose.yml 文件，删除 command: --skip-grant-tables 。
# 重新启动容器：
docker-compose down
docker-compose up -d

# 验证修复后的权限
docker exec -it my_mysql mysql -u root -p
sql> SELECT User, Host FROM mysql.user;

# ERROR 1290 (HY000): The MySQL server is running with the --skip-grant-tables option so it cannot execute this statement
# 确保 MySQL 正在以 --skip-grant-tables 模式运行, 然后进入容器并登录：
docker exec -it my_mysql mysql
# 在会话中重新启用权限校验
sql> SET GLOBAL read_only = OFF; -- 如果 read_only 模式启用，则需要关闭
sql> SET SESSION sql_log_bin = 0; -- 禁用二进制日志记录
sql> FLUSH PRIVILEGES;
# 修改用户权限
sql> UPDATE mysql.user SET Grant_priv = 'Y', Super_priv = 'Y' WHERE User = 'root';
sql> GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
sql> GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
# 在完成权限修复后，停止容器并移除 --skip-grant-tables 参数以恢复正常模式：
docker-compose down
docker-compose up -d
