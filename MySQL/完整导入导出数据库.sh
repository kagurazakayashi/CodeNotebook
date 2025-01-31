# 完整导入导出数据库
# 导出完整库，并完整导入到另一个 MySQL 实例中，包括 函数、存储过程、表、视图、数据。

# 导出数据库
mysqldump -u用户名 -p密码 --host=数据库地址 --port=端口号 --routines --triggers --events --databases 数据库名 > 导出文件.sql
# 参数说明：
# -u 和 -p：分别指定用户名和密码。
# --host 和 --port：可选项，指定远程数据库地址和端口（如果是本地则不需要）。
# --routines：导出存储过程和函数。
# --triggers：导出触发器。
# --events：导出事件调度器。
# --databases：指定要导出的数据库名称。
# > 导出文件.sql：将导出的内容保存到指定文件。

# 导入数据库
# 创建数据库（如果尚未创建）：
mysql -u用户名 -p密码 -h目标数据库地址 -P端口号
sql> CREATE DATABASE my_database CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
sql> GRANT ALL PRIVILEGES ON my_database.* TO '用户名'@'%' WITH GRANT OPTION; -- 确保用户有权限操作新建的库
sql> FLUSH PRIVILEGES;
sql> \q
# 导入数据：
mysql -u用户名 -p密码 --host=目标数据库地址 --port=端口号 my_database < my_database_dump.sql
# 确认源数据库和目标数据库的字符集一致，避免乱码问题。
# 大数据文件导入：
# 如果 .sql 文件过大，可能需要调整 MySQL 配置：
# 修改 max_allowed_packet 和 net_buffer_length。
# 配置文件路径：/etc/my.cnf 或 /etc/mysql/my.cnf。

# ERROR 1418 (HY000) at line 1612: This function has none of DETERMINISTIC, NO SQL, or READS SQL DATA in its declaration and binary logging is enabled (you *might* want to use the less safe log_bin_trust_function_creators variable)
# 需要允许创建没有明确声明这些属性的函数或存储过程。
mysql -u用户名 -p密码
sql> SET GLOBAL log_bin_trust_function_creators = 1;
sql> \q
# 再次操作导入, 然后改回去
sql> SET GLOBAL log_bin_trust_function_creators = 0;
sql> \q