-- 错误提示： The total number of locks exceeds the lock table size

show variables like "%_buffer%";
SET GLOBAL innodb_buffer_pool_size=16777216; --默认值16M