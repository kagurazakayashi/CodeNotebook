-- 最大ID
select max(id) from tablename;
-- 最大ID的整个行内容
select * from tablename where id=(select max(id) from tablename);