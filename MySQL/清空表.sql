-- 选定数据库
USE `数据库名称`

-- 逐条删除 (速度较慢) 写服务器 log
-- 可配合 where
DELETE * FROM `表名`;

-- 整体删除 (速度较快) 不写服务器 log
-- 不激活trigger (触发器)，但是会重置Identity (标识列、自增字段)
TRUNCATE TABLE `表名`;