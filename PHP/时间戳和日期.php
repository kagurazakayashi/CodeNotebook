时间戳转日期 date()
time()

<?php
var_dump(time()); //获取当前时间戳 int(1502245603)
?>

date(format,timestamp)

format 必需。规定时间戳的格式。
timestamp 可选。规定时间戳。默认是当前时间和日期

时间戳转日期，可以用date(‘Y-m-s h:i:s’, 具体时间戳来实现).

Y ：年（四位数）大写
m : 月（两位数，首位不足补0） 小写
d ：日（两位数，首位不足补0） 小写
H ：小时 带有首位零的 24 小时小时格式
h ：小时 带有首位零的 12 小时小时格式
i ：带有首位零的分钟
s ：带有首位零的秒（00 -59）
a ：小写的午前和午后（am 或 pm）

大小写的区分非常重要，例如以下例子：
<?php
var_dump(date('Y-m-d H:i:s', 1502204401)); //H 24小时制 2017-08-08 23:00:01
var_dump(date('Y-m-d h:i:s', 1502204401)); //h 12小时制 2017-08-08 11:00:01
?>

日期转时间戳 strtotime()
strotime是非常灵活聪明的函数，可以识别中文，英文，数字，我们来感受一下

<?php
echo strtotime("now"), "\n";
echo strtotime("10 September 2000"), "\n";
echo strtotime("+1 day"), "\n";
echo strtotime("+1 week"), "\n";
echo strtotime("+1 week 2 days 4 hours 2 seconds"), "\n";
echo strtotime("next Thursday"), "\n";
echo strtotime("last Monday"), "\n";
echo strtotime("20170808 23:00:01"), "\n";
?>
