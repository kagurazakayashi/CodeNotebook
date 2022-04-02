-- HAVING 子句可以让我们筛选分组后的各组数据。
-- WHERE 子句作用于表和视图，HAVING 子句作用于组。

-- 一、显示每个地区的总人口数和总面积．
SELECT region, SUM(population), SUM(area) FROM bbc GROUP BY region
-- 先以region把返回记录分成多个组，这就是GROUP BY的字面含义。分完组后，然后用聚合函数对每组中的不同字段（一或多条记录）作运算。

-- 二、 显示每个地区的总人口数和总面积．仅显示那些面积超过1000000的地区。
SELECT region, SUM(population), SUM(area)
FROM bbc
GROUP BY region
HAVING SUM(area)>1000000
-- 在这里，我们不能用where来筛选超过1000000的地区，因为表中不存在这样一条记录。
-- 相反，having子句可以让我们筛选成组后的各组数据