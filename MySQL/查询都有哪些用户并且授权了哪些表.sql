-- 查询都有哪些用户并且授权了哪些表

-- 查看都有哪些用户
SELECT user, host FROM mysql.user ORDER BY user, host;
-- +------------------+-----------+
-- | user             | host      |
-- +------------------+-----------+
-- | mysql.infoschema | localhost |
-- | mysql.session    | localhost |
-- | mysql.sys        | localhost |
-- | root             | %         |
-- +------------------+-----------+

-- 查看某个用户授予了哪些权限
SHOW GRANTS FOR 'mysql.sys'@'localhost';
-- +---------------------------------------------------------------+
-- | Grants for mysql.sys@localhost                                |
-- +---------------------------------------------------------------+
-- | GRANT USAGE ON *.* TO `mysql.sys`@`localhost`                 |
-- | GRANT SYSTEM_USER ON *.* TO `mysql.sys`@`localhost`           |
-- | GRANT TRIGGER ON `sys`.* TO `mysql.sys`@`localhost`           |
-- | GRANT SELECT ON `sys`.`sys_config` TO `mysql.sys`@`localhost` |
-- +---------------------------------------------------------------+

-- 查看某个库的权限
SELECT 
    Db      AS mysql,
    Select_priv,
    Insert_priv,
    Update_priv,
    Delete_priv,
    Create_priv,
    Drop_priv
FROM mysql.db
ORDER BY Db, User, Host;
-- +--------------------+-------------+-------------+-------------+-------------+-------------+-----------+
-- | mysql              | Select_priv | Insert_priv | Update_priv | Delete_priv | Create_priv | Drop_priv |
-- +--------------------+-------------+-------------+-------------+-------------+-------------+-----------+
-- | performance_schema | Y           | N           | N           | N           | N           | N         |
-- | scada-lts          | Y           | Y           | Y           | Y           | Y           | Y         |
-- | scadalts           | Y           | Y           | Y           | Y           | Y           | Y         |
-- | sys                | N           | N           | N           | N           | N           | N         |
-- +--------------------+-------------+-------------+-------------+-------------+-------------+-----------+

--  列出所有用户的权限查询命令
SELECT 
    CONCAT("SHOW GRANTS FOR '", user, "'@'", host, "';") AS show_grant_sql
FROM mysql.user
ORDER BY user, host;
-- +-------------------------------------------------+
-- | show_grant_sql                                  |
-- +-------------------------------------------------+
-- | SHOW GRANTS FOR 'mysql.infoschema'@'localhost'; |
-- | SHOW GRANTS FOR 'mysql.session'@'localhost';    |
-- | SHOW GRANTS FOR 'mysql.sys'@'localhost';        |
-- | SHOW GRANTS FOR 'mytongdy'@'%';                 |
-- | SHOW GRANTS FOR 'root'@'%';                     |
-- | SHOW GRANTS FOR 'root'@'localhost';             |
-- | SHOW GRANTS FOR 'sales_rec'@'%';                |
-- +-------------------------------------------------+
SHOW GRANTS FOR 'root'@'%'\G
