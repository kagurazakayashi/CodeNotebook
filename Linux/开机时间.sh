cat /proc/uptime
# 4700.02 222020.02

date -d "`cut -f1 -d. /proc/uptime` seconds ago"
# 2021年 06月 22日 星期二 11:46:56 CST

date -d "$(awk -F. '{print $1}' /proc/uptime) second ago" +"%Y-%m-%d %H:%M:%S" 
# 2021-06-22 11:46:55


# 历史启动的时间
last reboot
# reboot   system boot  4.18.0-147.el8.x Fri Mar  6 15:51 - 16:38  (00:46)

# 最后一次系统启动的时间
who -b
# 系统引导 2021-06-22 11:46

# 当前系统运行时间
who -r
# 运行级别 3 2021-06-22 11:47


uptime
# 13:08:17 up  1:21,  1 user,  load average: 1.04, 1.07, 1.00

w
# 13:07:54 up  1:20,  1 user,  load average: 0.42, 0.95, 0.96