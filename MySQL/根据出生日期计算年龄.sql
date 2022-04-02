-- 根据出生日期计算年龄
SELECT TIMESTAMPDIFF(YEAR,@birthday,CURDATE());
SELECT TIMESTAMPDIFF(YEAR,(SELECT registertime FROM test0.user where `id`=2),CURDATE());
-- https://blog.csdn.net/qq_26496877/article/details/102651600