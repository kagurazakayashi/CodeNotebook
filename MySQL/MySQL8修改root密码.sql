use mysql;
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '新密码';
FLUSH PRIVILEGES;

-- 另一种修改密码的方式
-- mysqladmin -u root -p password 新密码