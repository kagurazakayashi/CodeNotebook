# 向进程发送信号（signal）或者软件中断（software interrupt）
# 信号（signal）是软件模拟硬件中断（interrupt）
# kill [信号编号] [进程ID列表]
# -s  指定信号编号 signal_number
# -a  当处理当前进程时，不限制命令名和进程号的对应关系
# -p  指定kill 命令只打印相关进程的进程号，而不发送任何信号
# -u  指定用户
# -l  信号，若果不加信号的编号参数，则使用“-l”参数会列出全部的信号名称
# proc-list 进程ID列表，作业号以 % 开头

# 显示所有的信号和名字
kill -l
# HUP INT QUIT ILL TRAP ABRT BUS FPE KILL USR1 SEGV USR2 PIPE ALRM TERM STKFLT CHLD CONT STOP TSTP TTIN TTOU URG XCPU XFSZ VTALRM PROF WINCH POLL PWR SYS
#  1) SIGHUP       2) SIGINT       3) SIGQUIT      4) SIGILL
#  5) SIGTRAP      6) SIGABRT      7) SIGBUS       8) SIGFPE
#  9) SIGKILL     10) SIGUSR1     11) SIGSEGV     12) SIGUSR2
# 13) SIGPIPE     14) SIGALRM     15) SIGTERM     16) SIGSTKFLT
# 17) SIGCHLD     18) SIGCONT     19) SIGSTOP     20) SIGTSTP
# 21) SIGTTIN     22) SIGTTOU     23) SIGURG      24) SIGXCPU
# 25) SIGXFSZ     26) SIGVTALRM   27) SIGPROF     28) SIGWINCH
# 29) SIGIO       30) SIGPWR      31) SIGSYS      34) SIGRTMIN
# 35) SIGRTMIN+1  36) SIGRTMIN+2  37) SIGRTMIN+3  38) SIGRTMIN+4
# 39) SIGRTMIN+5  40) SIGRTMIN+6  41) SIGRTMIN+7  42) SIGRTMIN+8
# 43) SIGRTMIN+9  44) SIGRTMIN+10 45) SIGRTMIN+11 46) SIGRTMIN+12
# 47) SIGRTMIN+13 48) SIGRTMIN+14 49) SIGRTMIN+15 50) SIGRTMAX-14
# 51) SIGRTMAX-13 52) SIGRTMAX-12 53) SIGRTMAX-11 54) SIGRTMAX-10
# 55) SIGRTMAX-9  56) SIGRTMAX-8  57) SIGRTMAX-7  58) SIGRTMAX-6
# 59) SIGRTMAX-5  60) SIGRTMAX-4  61) SIGRTMAX-3  62) SIGRTMAX-2
# 63) SIGRTMAX-1  64) SIGRTMAX
# 常用的信号编号
# HUP     1    终端断线
# INT     2    中断（同 Ctrl + C）
# QUIT    3    退出（同 Ctrl + \）
# TERM   15    终止
# KILL    9    强制终止
# CONT   18    继续（与STOP相反， fg/bg命令）
# STOP   19    暂停（同 Ctrl + Z）

# 使用信号 2 (SIGINT) 要求 2678 进程停止 (Ctrl+C)
kill -s SIGINT 2678
# [1]+  Interrupt    ./noend.out
# 使用信号 9 (SIGKILL) 直接终止 2678 进程
kill -9 2678
# [1]+  Killed       ./noend.out

# 结束 job 作业
# 显示正在进行中的后台程序
jobs
# [1]+  Running      ./noend.out &
# 结束后台程序 [1]
kill %1

# 杀死指定用户所有进程
kill -9 $(ps -ef | grep username)
kill -u username

# https://www.cnblogs.com/peida/archive/2012/12/20/2825837.html