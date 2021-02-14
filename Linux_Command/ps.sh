# 报告当前进程状态，当前进程的快照 snapshot 。
ps
#     PID TTY          TIME CMD
#    6730 pts/1    00:00:00 zsh
#    7996 pts/1    00:00:00 ps
# ps [options]
# a  显示所有进程
# -a 在当前终端上运行的进程，当前的 Shell 除外。
# c  显示进程的真实名称
# -N 反向选择
# -e / -A 在系统中运行的所有进程。
# -f 显示父进程（双亲进程） PID 。
# -l 以长列表格式显示进程状态（14列）。
# -u 进程的所有者。
# -x 没有控制终端的进程。
# -H 显示树状结构
# r  显示当前终端的进程
# T  显示当前终端的所有程序
# u  指定用户的所有进程
# -au 显示较详细的资讯
# -aux 显示所有包含其他使用者的行程
# -C<命令> 列出指定命令的状况
# --lines<行数> 每页显示的行数
# --width<字符数> 每页显示的字符数
# --help 显示帮助信息
# --version 显示版本显示

# -l 选项:
# Field Meaning
# F   Flag: 指定是用户进程或者内核进程，进程为什么停止和休眠。
# S   State: 进程的状态
#     O 正在运行
#     R 准备运行
#     S 休眠，等待事件
#     T 停止，后台进程，挂起，正在被跟踪
#     Z 结束
# UID 进程所有者用户 ID
# PID 进程 ID
# PPID 双亲进程 ID
#      ID 1 (init) 是祖先进程，所有进程追踪 PPID 都能到 1

# 以长列表格式显示进程状态
ps -l
# 用户　状　用户　进程　双亲进　处理器　优　Ni　内存　内存　是否运　终端　处理器　命令行
# 内核　态　ＩＤ　ＩＤ　程ＩＤ　使用量　先　ce　部分　使用　作当中　位置　　时间　指令
#  F   S   UID   PID  PPID   C   PRI  NI ADDR  SZ   WCHAN   TTY     TIME CMD
#  4   S     0  6730  6729   0    80   0    - 67533     - pts/1 00:00:00 zsh
#  0   R     0  6834  6730   0    80   0    - 63798     - pts/1 00:00:00 ps
# F 代表这个程序的旗标 (flag)， 4 代表使用者为 super user
# S 代表这个程序的状态 (STAT)，关于各 STAT 的意义将在内文介绍
# UID 程序被该 UID 所拥有
# PID 就是这个程序的 ID ！
# PPID 则是其上级父程序的ID
# C CPU 使用的资源百分比
# PRI 这个是 Priority (优先执行序) 的缩写，详细后面介绍
# NI 这个是 Nice 值，在下一小节我们会持续介绍
# ADDR 这个是 kernel function，指出该程序在内存的那个部分。如果是个 running的程序，一般就是 "-"
# SZ 使用掉的内存大小
# WCHAN 目前这个程序是否正在运作当中，若为 - 表示正在运作
# TTY 登入者的终端机位置
# TIME 使用掉的 CPU 时间。
# CMD 所下达的指令为何
# 在预设的情况下， ps 仅会列出与目前所在的 bash shell 有关的 PID 而已，所以 ps -l 的时候，只有2个 PID。

# 列出目前所有的正在内存当中的程序
ps a
# 更多信息
ps aux
# USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
# root           1  0.1  0.1 243412 11892 ?        Ss   13:48   0:02 /usr/lib/syst
# root           2  0.0  0.0      0     0 ?        S    13:48   0:00 [kthreadd]
# root           3  0.0  0.0      0     0 ?        I<   13:48   0:00 [rcu_gp]
# root           4  0.0  0.0      0     0 ?        I<   13:48   0:00 [rcu_par_gp]
# USER：该 process 属于那个使用者账号的
# PID ：该 process 的号码
# %CPU：该 process 使用掉的 CPU 资源百分比
# %MEM：该 process 所占用的物理内存百分比
# VSZ ：该 process 使用掉的虚拟内存量 (Kbytes)
# RSS ：该 process 占用的固定的内存量 (Kbytes)
# TTY ：该 process 是在那个终端机上面运作，若与终端机无关，则显示 ?，另外， tty1-tty6 是本机上面的登入者程序，若为 pts/0 等等的，则表示为由网络连接进主机的程序。
# STAT：该程序目前的状态，主要的状态有
# R ：该程序目前正在运作，或者是可被运作
# S ：该程序目前正在睡眠当中 (可说是 idle 状态)，但可被某些讯号 (signal) 唤醒。
# T ：该程序目前正在侦测或者是停止了
# Z ：该程序应该已经终止，但是其父程序却无法正常的终止他，造成 zombie (疆尸) 程序的状态
# START：该 process 被触发启动的时间
# TIME ：该 process 实际使用 CPU 运作的时间
# COMMAND：该程序的实际指令

# https://www.cnblogs.com/peida/archive/2012/12/19/2824418.html