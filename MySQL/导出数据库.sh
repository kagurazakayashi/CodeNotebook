mysql -u root -p
# 查询mysql中所有数据库名称
mysql> SELECT `SCHEMA_NAME` FROM `information_schema`.`SCHEMATA`;
mysql> exit
# mysqldump -u 用户名 -p 数据库名 > 导出的文件名
mysqldump -u root -p information_schema > information_schema.sql
mysqldump -u root -p mysql > mysql.sql
mysqldump -u root -p performance_schema > performance_schema.sql
mysqldump -u root -p sys > sys.sql
mysqldump -u root -p mytongdy > mytongdy.sql
# 压缩
tar -zcvf sql.tar.gz *.sql
7za a -mx9 sql.7z *.sql -v100m -p1cYnVDicm4FBwOvy
# 恢复
mysqldump -u root -p mytongdy < mytongdy.sql

# 备份还原
https://www.cnblogs.com/Vitus_feng/archive/2010/05/21/1741262.html
https://www.cnblogs.com/kevingrace/p/9403353.html