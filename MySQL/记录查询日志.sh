# Windows: 
# Linux:
vim /etc/my.cnf

# 慢查询
long_query_time=2
slow_query_log=1
slow_query_log_file=/log/mysql_slow_query.log
# 记录没有使用索引的查询日志：
log_queries_not_using_indexes=1

# 所有操作日志
general_log=on
general_log_file=/log/mysql_query.log