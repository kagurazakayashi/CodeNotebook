-- 查询都有什么库和什么表

-- 连接
mysql -h172.18.0.2 -P3306 -uroot -p

-- 查看所有数据库
SHOW DATABASES;
-- +--------------------+
-- | Database           |
-- +--------------------+
-- | information_schema |
-- | logs_0             |
-- | mysql              |
-- | performance_schema |
-- | phpmyadmin         |
-- | sys                |
-- +--------------------+

-- 查看某个数据库中的所有表
USE mysql;
+------------------------------------------------------+
| Tables_in_mysql                                      |
+------------------------------------------------------+
| time_zone                                            |
| user                                                 |
+------------------------------------------------------+

-- 查看表结构
DESC user;
+--------------------------+-----------------------------------+------+-----+-----------------------+-------+
| Field                    | Type                              | Null | Key | Default               | Extra |
+--------------------------+-----------------------------------+------+-----+-----------------------+-------+
| Host                     | char(255)                         | NO   | PRI |                       |       |
| User                     | char(32)                          | NO   | PRI |                       |       |
| ssl_type                 | enum('','ANY','X509','SPECIFIED') | NO   |     |                       |       |
| plugin                   | char(64)                          | NO   |     | caching_sha2_password |       |
| authentication_string    | text                              | YES  |     | NULL                  |       |
| password_expired         | enum('N','Y')                     | NO   |     | N                     |       |
| password_last_changed    | timestamp                         | YES  |     | NULL                  |       |
| password_lifetime        | smallint unsigned                 | YES  |     | NULL                  |       |
| Password_reuse_history   | smallint unsigned                 | YES  |     | NULL                  |       |
| Password_reuse_time      | smallint unsigned                 | YES  |     | NULL                  |       |
| Password_require_current | enum('N','Y')                     | YES  |     | NULL                  |       |
| User_attributes          | json                              | YES  |     | NULL                  |       |
+--------------------------+-----------------------------------+------+-----+-----------------------+-------+

-- 查看表的建表语句
SHOW CREATE TABLE user\G
-- ;   横向表格  普通查询
-- \G  垂直纵向  长字段、大段 SQL、结构查看

-- 查看库里所有表的大小（排序显示）
SELECT 
    table_name AS 'Table',
    ROUND((data_length + index_length)/1024/1024, 2) AS 'Size_MB'
FROM information_schema.tables
WHERE table_schema = 'mysql'
ORDER BY Size_MB DESC;
