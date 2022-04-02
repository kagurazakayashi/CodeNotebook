-- IS 一般情况下和 NULL 连用，比较该字段的值是否为空
-- IS 只能用于返回 true, false 或 NULL 的变量

-- 找出所有name为空的记录
SELECT * FROM table_name WHERE name IS NULL

-- =: 比如两个值是否相等
-- 找出所有名称为“张三”的记录
select * from table_name where name = '张三'