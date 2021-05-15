mysqldump  -uroot -p123456 jx --where "1=1 limit 100" --lock-all-tables > g:backup100.sql
# 或
mysqldump  -uroot -p jx --where="true limit 100"> g:backup100.sql
# 回车 再输入密码
# 但是要求mysql账户有执行这个命令的权限。