# crontab计划任务
# 日志
tail -f /var/log/cron
# 重启
systemctl restart crond
/etc/init.d/crond restart
# 编辑
crontab -e

# 分 时 日 月 周 命令
# 59 23 31 12 6 # 0=周日
* * * * * command

# 每1分钟执行一次command
* * * * * command

# 每小时的第3和第15分钟执行
3,15 * * * * command

# 在上午8点到11点的第3和第15分钟执行
3,15 8-11 * * * command

# 每两天的上午8点到11点的第3和第15分钟执行
3,15 8-11 */2 * * command

# 每个星期一的上午8点到11点的第3和第15分钟执行
3,15 8-11 * * 1 command

# 每晚的21:30重启smb
30 21 * * * /etc/init.d/smb restart

# 每月1、10、22日的4 : 45重启smb
45 4 1,10,22 * * /etc/init.d/smb restart

# 每周六、周日的1 : 10重启smb
10 1 * * 6,0 /etc/init.d/smb restart

# 每天18 : 00至23 : 00之间每隔30分钟重启smb
0,30 18-23 * * * /etc/init.d/smb restart

# 每星期六的晚上11 : 00 pm重启smb
0 23 * * 6 /etc/init.d/smb restart

# 每天早上5点36分重新启动
36 5 * * * reboot

# 开机时运行某个脚本
@reboot /home/user/test.sh