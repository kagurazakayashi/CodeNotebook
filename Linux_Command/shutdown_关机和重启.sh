shutdown -h now # = halt    立即关闭系统
shutdown -r now # = reboot  立即重新启动系统
shutdown -h 10  # 10 分钟后关机

# shutdown [-t seconds] [-rkhncfF] time [message]
# -t seconds : 设定在几秒钟之后进行关机程序。
# -k : 并不会真的关机，只是将警告讯息传送给所有使用者。
# -r : 关机后重新开机。
# -h : 关机后停机。
# -n : 不采用正常程序来关机，用强迫的方式杀掉所有执行中的程序后自行关机。
# -c : 取消目前已经进行中的关机动作。
# -f : 关机时，不做 fcsk 动作(检查 Linux 档系统)。
# -F : 关机时，强迫进行 fsck 动作。
# time : 设定关机的时间。
# message : 传送给所有使用者的警告讯息。