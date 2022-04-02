-- 统计全部值的数量
SELECT count(*) FROM `employee`;

-- 统计不含空值的数量
SELECT count(`d_id`) FROM `employee`;

-- 统计不含重复值的数量
SELECT count(distinct `d_id`) FROM `employee`;
