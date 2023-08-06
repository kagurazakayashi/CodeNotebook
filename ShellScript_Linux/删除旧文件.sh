# 删除旧文件 删除几天前文件 删除指定时间前文件

#定义删除的时间，2天前的，2天内的为-2，查找到的输出到日志
find /logs -mtime +2 -name ".log" >> delete.log

#查找到的文件并删除
find /logs -mtime +2 -name ".gz" -exec rm -rf {} ;
