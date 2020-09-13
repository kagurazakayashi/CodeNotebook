# 显示当前登录的用户名（Windows可用）
whoami
# yashi

# 显示当前主机的名称（Windows可用）
hostname
# KYS-PC9-OS1.local

# 显示当前登录的所有用户（包括终端）
who
# yashi    console  Sep 13 12:03
# yashi    ttys000  Sep 13 12:06

# 退出（快捷键 Ctrl+D ）
# Ctrl+D 在 Linux 中表示文件结束符
exit

# 显示当前 UNIX 操作系统的名字
uname
# Darwin
# Linux
# 显示当前操作系统详细信息（包括内核版本）
uname -a
# Darwin KYS-PC9-OS1.local 19.6.0 Darwin Kernel Version 19.6.0: Thu Jun 18 20:49:00 PDT 2020; root:xnu-6153.141.1~1/RELEASE_X86_64 x86_64

# 显示当前系统统计信息（包括系统启动时间）
uptime
# 14:59  up  2:56, 2 users, load averages: 3.23 3.39 3.03
# 15:31:30 //系统当前时间
# up 127 days,  3:00 //主机已运行时间,时间越大，说明你的机器越稳定。
# 1 user //用户连接数，是总连接数而不是用户数
# load average: 0.00, 0.00, 0.00 // 系统平均负载，统计最近1，5，15分钟的系统平均负载

# 显示当前系统日期和时间
date
# 2020年 9月13日 星期日 15时03分27秒 CST
date -d mm/dd/yyyy # 设置日期
date -s hh:mm:ss # 设置时间

# 显示日历
cal
cal 2020 # 全年日历
cal 9 1752 # 显示某年某月
# 此月情况 https://zh.wikipedia.org/zh-hans/1752%E5%B9%B4
cal -3 # 显示上个月、这个月、下个月 三个月的日历

# 输出当前工作目录
pwd
# /Users/yashi

# 改变当前工作目录
cd /Users
pwd
# /Users
# 前往上层目录
cd ..
pwd
# /   # 表示根目录
# ..  # 表示上层目录
# 不带任何参数 cd ：回到用户主目录（等同于 cd ~ ）
# root 用户的主目录是 /root （root 用户登录系统以后，默认进入 /root 目录）

# 建立子目录
mkdir

# 删除子目录（仅限空目录）
rmdir

# 删除文件
rm 1.txt    # 单个文件
rm -r dir   # 递归删除
rm -f 1.txt # 强制删除

# echo (输出) > (到) 1.txt (文件)
echo "hi" > 1.txt
# 显示文件内容 连接(concatenate)
cat

# 显示当前目录中的文件列表
ls
# 蓝色为文件夹，默认色为文件
# 绿色为可执行文件
ls -l # long 长格式 显示文件详细信息
# 权限 0 用户名 主名 大小 时间
# drwxr-xr-x 12 yashi  staff   384  9 12 21:37 meow

# 类型 用户权限 组权限 其他用户权限
#  d    rwx    r-x      r-x
# d 文件夹,  - 文件,  r 可读,  w 可写,  x 可运行