# sh时间 sh日期
date +%Y-%m-%d
# 2011-07-28

# 传给变量：
DATE=$(date +%Y%m%d)

# 当前时间戳
date +%s

# 获取明天的日期
date -d next-day +%Y%m%d

# 获取昨天的日期
date -d last-day +%Y%m%d

# 获取上个月的年和月
date -d last-month +%Y%m

# 获取下个月的年和月
date -d next-month +%Y%m

# 获取明年的年份
date -d next-year +%Y

# 生成带日期的文件名
echo access_`date +%Y-%m-%d_%H-%M-%S`.log
# access_2019-12-20_00-19-40.log
echo access_`date +%Y%m%d_%H%M`.log
# access_20191220_0019.log

# % : 印出
# % %n : 下一行
# %t : 跳格
# %H : 小时(00..23)
# %I : 小时(01..12)
# %k : 小时(0..23)
# %l : 小时(1..12)
# %M : 分钟(00..59)
# %p : 显示本地 AM 或 PM
# %r : 直接显示时间 (12 小时制，格式为 hh:mm:ss [AP]M)
# %s : 从 1970 年 1 月 1 日 00:00:00 UTC 到目前为止的秒数 %S : 秒(00..61)
# %T : 直接显示时间 (24 小时制)
# %X : 相当于 %H:%M:%S
# %Z : 显示时区
# 日期方面 :
# %a : 星期几 (Sun..Sat)
# %A : 星期几 (Sunday..Saturday)
# %b : 月份 (Jan..Dec)
# %B : 月份 (January..December)
# %c : 直接显示日期和时间 
# %d : 日 (01..31)
# %D : 直接显示日期 (mm/dd/yy)
# %h : 同 %b
# %j : 一年中的第几天 (001..366)
# %m : 月份 (01..12)
# %U : 一年中的第几周 (00..53) (以 Sunday 为一周的第一天的情形)
# %w : 一周中的第几天 (0..6)
# %W : 一年中的第几周 (00..53) (以 Monday 为一周的第一天的情形)
# %x : 直接显示日期 (mm/dd/yy)
# %y : 年份的最后两位数字 (00.99)
# %Y : 完整年份 (0000..9999)
