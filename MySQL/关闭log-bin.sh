# 先登录数据库查询log-bin的状态（8.0版本默认是开启的！）。
mysql> show variables like 'log_bin';
# 注释掉
#log-bin=mysql-bin

# 关闭方法
# 编辑my.cnf文件，一般路径为：/etc/my.cnf
# 在mysqld下面添加：skip-log-bin

# 重启Mysql
/etc/init.d/mysqld restart;

# 再次查看状态，为关闭状态