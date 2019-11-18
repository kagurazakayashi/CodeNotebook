-- 普通表
SELECT count(*) FROM `表名`;

-- 大表/粗略统计
SELECT `table_name`,`table_rows` FROM `information_schema`.`tables` WHERE `table_schema` = '数据库名' AND `table_name` = '表名';

-- 大表/粗略统计：所有的表数据量并排序
SELECT `table_name`,`table_rows` FROM `information_schema`.`tables` WHERE `table_schema` = '数据库名' ORDER BY `table_rows` desc;