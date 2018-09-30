-- date 某天
SELECT * FROM `racing_live_audiences` WHERE `time` LIKE '2018-06-13'

-- datetime 某天
select * from `racing_live_audiences` where date_format(usetime,'%Y-%m-%d') = '2018-06-13';

-- 区间
SELECT * FROM `库`.`表` WHERE '字段' BETWEEN '2018-08-01' AND '2018-09-18 16:09:20'

-- 今天
select * from `表名` where to_days('时间字段名') = to_days(now());

-- 昨天
SELECT * FROM `表名` WHERE TO_DAYS( NOW( ) ) - TO_DAYS( '时间字段名') <= 1

-- 7天
SELECT * FROM `表名` where DATE_SUB(CURDATE(), INTERVAL 7 DAY) <= date('时间字段名')

-- 近30天
SELECT * FROM `表名` where DATE_SUB(CURDATE(), INTERVAL 30 DAY) <= date('时间字段名')

-- 本月
SELECT * FROM `表名` WHERE DATE_FORMAT( '时间字段名', '%Y%m' ) = DATE_FORMAT( CURDATE( ) , '%Y%m' )

-- 上一月
SELECT * FROM `表名` WHERE PERIOD_DIFF( date_format( now( ) , '%Y%m' ) , date_format( '时间字段名', '%Y%m' ) ) =1

-- 查询本季度数据
select * from `information` where QUARTER(create_date)=QUARTER(now());

-- 查询上季度数据
select * from `information` where QUARTER(create_date)=QUARTER(DATE_SUB(now(),interval 1 QUARTER));

-- 查询本年数据
select * from `information` where YEAR(create_date)=YEAR(NOW());

-- 查询上年数据
select * from `information` where year(create_date)=year(date_sub(now(),interval 1 year));

-- 查询当前这周的数据
SELECT 'name','submittime' FROM `enterprise` WHERE YEARWEEK(date_format(submittime,'%Y-%m-%d')) = YEARWEEK(now());

-- 查询上周的数据
SELECT 'name','submittime' FROM `enterprise` WHERE YEARWEEK(date_format(submittime,'%Y-%m-%d')) = YEARWEEK(now())-1;

-- 查询当前月份的数据
select 'name','submittime' from `enterprise`   where date_format(submittime,'%Y-%m')=date_format(now(),'%Y-%m')

-- 查询距离当前现在6个月的数据
select 'name','submittime' from `enterprise` where submittime between date_sub(now(),interval 6 month) and now();

-- 查询上个月的数据
select 'name','submittime' from `enterprise`   where date_format(submittime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m')
