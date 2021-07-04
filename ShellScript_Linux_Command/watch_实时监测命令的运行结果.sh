# 实时监测命令的运行结果

# FreeBSD和Linux下watch命令的不同 
# 在Linux下，watch是周期性的执行下个程序，并全屏显示执行结果。 
# -d, --differences[=cumulative]   高亮显示变动
# -n, --interval=                  周期(秒)
# -t 或 -no-title                  会关闭watch命令在顶部的时间间隔
# 如：
watch -n 1 -d netstat -ant
# 而在FreeBSD下的watch命令是查看其它用户的正在运行的操作，watch允许你偷看其它terminal正在做什么，该命令只能让超级用户使用。

# 实时运行 uptime 命令（显示开机时间）
watch uptime

# -d 同时监控与上次的变化字， -t 不显示时间间隔
watch -t -d uptime

# -n 1 每隔一秒查看一下网络变化
watch -d -n 1 netstat -ntlp

# 监测磁盘空间 inode和block数目变化情况
watch -n 1 "df -i -h -l;df"

# 查看usb3.0拷贝到该目录下面的速度
watch -n 60 -d du -ah


# 动态监测当前目录中的文件变化
watch -d -n 1 -t 'ls -AltF .'

# AltF:
# -F 在文件后面加一个文件符号表示文件类型
# 共有 */=>@| 这几种类型，* 表示可执行文件，/ 表示目录，= 表示接口( sockets) ，> 表示门， @ 表示符号链接， | 表示管道。
# -l 以列表方式显示
# -A 和 -a 的区别就是 -A 不显示 . 和 … 文件夹，其他一样
# -t 根据时间排序文件

watch -d -n 1 'df; ls -Alt -F /path'
# 在使用这条命令时你需要替换其中的 /path 部分，watch 是实时监控工具
# -d 参数会高亮显示变化的区域，-n 1 参数表示刷新间隔为 1 秒。
# df; ls -FlAt /path 运行了两条命令，df 是输出磁盘使用情况，ls -FlAt 则列出 /path 下面的所有文件。
# ls -FlAt 的参数详解：
# -F 在文件后面加一个文件符号表示文件类型，共有 */=>@| 这几种类型，* 表示可执行文件，/ 表示目录，= 表示接口( sockets) ，> 表示门， @ 表示符号链接， | 表示管道。 
# -l 以列表方式显示 
# -A 不显示 . 和 .. 
# -t 根据时间排序文件

# https://blog.csdn.net/tao_627/article/details/18922795