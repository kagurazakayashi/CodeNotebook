# 说明：+n 大于 n, -n 小于 n, n 相等于 n.
find / -amin -30 -ls # 查找在系统中最后30分钟访问的文件
find / -atime -2 -ls # 查找在系统中最后48小时访问的文件
find / -mmin -10 -ls # 查找在系统中最后10分钟里修改过的文件
find / -mtime -1 -ls # 查找在系统中最后24小时里修改过的文件
find / -cmin -10 -ls # 查找在系统中最后10分钟里被改变状态的文件
find / -ctime -1 -ls # 查找在系统中最后24小时里被改变状态的文件

# 删除tmp目录下3天前所有子文件，如果不带*，则会干掉此非空目录
/usr/bin/find /data/htdocs/test.cn/data/tmp/* -mtime +3 -ls

# [正常情况下：atime 与 mtime所找到的文件个数是相等的]

# 删除三天前，遗留的dump文件
day=$(/bin/date +%Y-%m-%d);
count=`/usr/bin/find /data/htdocs/test.cn/data/tmp/* -mtime +3 | wc -l`;
/usr/bin/find /data/htdocs/test.cn/data/tmp/* -mtime +3 -delete;
echo $day – $count;

#删除10天前的所有文件
find /tmp/* -type f -mtime +10 -exec rm {} \;

#查找10天前的所有文件
find /tmp/* -type f -mtime +10 -exec ls -l {} \;

# 可以配合脚本命令，定时自动删除安卓QQ的15天前的图片缓存
find /sdcard/tencent/*/*/.photo/* -type f -mtime +15 -exec rm {} \;