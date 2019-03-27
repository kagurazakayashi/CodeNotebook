# 1.检查mysql数据库存放目录
mysql -u root -prootadmin
#进入数据库
show variables like '%dir%';        
#查看sql存储路径
（查看datadir 那一行所指的路径）
quit;
# +-----------------------------------------+----------------------------------+
# | Variable_name                           | Value                            |
# +-----------------------------------------+----------------------------------+
# | basedir                                 | /usr/local/mysql/                |
# | binlog_direct_non_transactional_updates | OFF                              |
# | character_sets_dir                      | /usr/local/mysql/share/charsets/ |
# | datadir                                 | /usr/local/mysql/var/            |
# | ignore_db_dirs                          |                                  |
# | innodb_data_home_dir                    | /usr/local/mysql/var             |
# | innodb_log_group_home_dir               | /usr/local/mysql/var             |
# | innodb_max_dirty_pages_pct              | 75.000000                        |
# | innodb_max_dirty_pages_pct_lwm          | 0.000000                         |
# | innodb_tmpdir                           |                                  |
# | innodb_undo_directory                   | ./                               |
# | lc_messages_dir                         | /usr/local/mysql/share/          |
# | plugin_dir                              | /usr/local/mysql/lib/plugin/     |
# | slave_load_tmpdir                       | /tmp                             |
# | tmpdir                                  | /tmp                             |
# +-----------------------------------------+----------------------------------+

# 2.停止mysql服务
service mysqld stop

# 3.创建新的数据库存放目录
mkdir /data/mysql

# 4.复制之前存放数据库目录文件
cp -R /usr/local/mysql/var/* /data/mysql/

# 5.修改mysql数据库目录权限以及配置文件
chown -R mysql:mysql /mnt/data/mysql && chmod -R 755 /mnt/data/mysql
vim /etc/my.cnf
# datadir=/data/mysql （制定为新的数据存放目录）
vim /etc/init.d/mysqld
# datadir=/data/mysql

6.启动数据库服务
# service mysqld start