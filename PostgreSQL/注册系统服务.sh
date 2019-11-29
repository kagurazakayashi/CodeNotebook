# Windows
pg_ctl register -N PostgreSQL -D "C:\pgsql\data"
# Linux
find / -name start-scripts
cd /usr/local/pgsql/contrib/start-scripts
cp linux /etc/init.d/postgresql
chmod a+x /etc/init.d/postgresql
vim /etc/init.d/postgresql
# prefix设置为postgresql的安装路径: /www/server/pgsql
# PGDATA设置为postgresql的数据目录路径: /www/server/pgsql/data
service postgresql start
chown postgres:postgres /www/server/pgsql/logs

# 找安装目录
find . -name pg_ctl
# 列系统用户
cat /etc/passwd