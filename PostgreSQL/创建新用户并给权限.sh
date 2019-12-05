ln -s /tmp/.s.PGSQL.5432 /var/run/postgresql/.s.PGSQL.5432

# postgres 默认用户是postgres，为超级用户。
# 先以postgress 登录
psql -U postgres

# 创建数据库新用户
CREATE USER 用户名 WITH PASSWORD '*****';

# 授予用户数据库权限
GRANT ALL PRIVILEGES ON DATABASE 数据库名 TO 用户名;
# 给用户创建数据库的权限
ALTER ROLE 用户名 CREATEDB;

# 授予用户查看刚授权的数据库的里面的表的权限
GRANT ALL PRIVILEGES ON TABLE 表名 TO 用户名;

# https://blog.csdn.net/XuHang666/article/details/81506297