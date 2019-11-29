# 找到pg_hba.conf路径
ps ax | grep postgres | grep -v postgres:
# config_file=/etc/postgresql/9.3/main/就是我们配置所在地

# 无密码postgres登录
vim pg_hba.confg
# host all all 127.0.0.1/32 trust

# 重启postgresql服务
service postgresql restart

# 登录
psql -h 127.0.0.1 -U postgres

# 登录修改密码
alter user postgres with password 'YOUR　PASSWORD'

vim pg_hba.confg
# host all all 127.0.0.1/32 md5