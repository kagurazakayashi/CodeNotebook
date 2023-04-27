mysql -u root -p
# 查询mysql中所有数据库名称
mysql> SELECT `SCHEMA_NAME` FROM `information_schema`.`SCHEMATA`;
mysql> exit
# mysqldump -u 用户名 -p 数据库名 > 导出的文件名
mysqldump -u root -p information_schema > information_schema.sql
mysqldump -u root -p mysql > mysql.sql
mysqldump -u root -p performance_schema > performance_schema.sql
mysqldump -u root -p sys > sys.sql
# 压缩
# 带个最小压缩
mysqldump -u root -p performance_schema | nice -n 19 xz -z -1 -T 0 -v >performance_schema.sql.xz
# 恢复
#mysqldump -u root -p mytongdy < mytongdy.sql
mysql -uusername -ppassword db1 <tb1tb2.sql

# 备份还原
https://www.cnblogs.com/Vitus_feng/archive/2010/05/21/1741262.html
https://www.cnblogs.com/kevingrace/p/9403353.html

# 带密码导出
mysqldump -uroot -p123jhtyE\!W32df4456 dbname > ext.sql

# 复杂操作

# 导出所有数据库
mysqldump -uroot -proot --all-databases >/tmp/all.sql
# 导出db1、db2两个数据库的所有数据
mysqldump -uroot -proot --databases db1 db2 >/tmp/db1_and_db2.sql
# 导出db1中的a1、a2表
mysqldump -uroot -proot --databases db1 --tables a1 a2 >/tmp/db1.sql
# 条件导出，导出db1表a1中id=1的数据
mysqldump -uroot -proot --databases db1 --tables a1 --where='id=1' >/tmp/a1.sql
# 只导出表结构不导出数据，--no-data
mysqldump -uroot -proot --no-data --databases db1 >/tmp/db1.sql
# 跨服务器导出导入数据
mysqldump --host=h1 -uroot -proot --databases db1 |mysql --host=h2 -uroot -proot db2
# 加上-C参数可以启用压缩传递。
mysqldump --host=192.168.80.137 -uroot -proot -C --databases test |mysql --host=192.168.80.133 -uroot -proot test
# 导出结构不导出数据
mysqldump --opt -d db1 -u root -p > db1.sql
# 导出数据不导出结构
mysqldump -t db1 -uroot -p > db1.sql
# 全部
https://www.jianshu.com/p/c3d8366326c1