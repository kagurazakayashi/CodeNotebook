# 动态显示系统中最高占用CPU的进程的状态
top

# delay 延迟，间隔时间
top -d

# iter 重复显示的次数
top -n

# 所有参数
# -b         批处理
# -c         显示完整的命令
# -I         忽略失效过程
# -s         保密模式
# -S         累积模式
# -i<时间>   设置间隔时间
# -u<用户名> 指定用户名
# -p<进程号> 指定进程
# -n<次数>   循环显示的次数

# top - 当前系统时间 up 系统已经运行时间，几个用户登录，1分钟、5分钟、15分钟的负载情况。
# top - 14:24:04 up 35 min,  2 users,  load average: 0.04, 0.08, 0.40
# 所有进程，多少正在运行，多少休眠状态，多少停止，多少僵尸
# Tasks: 348 total,   1 running, 347 sleeping,   0 stopped,   0 zombie
# 用户空间占用us，内核空间占用sy，改变过优先级的进程ni，空闲CPU百分比id，IO等待占用CPU的百分比wa，硬中断（Hardware IRQ）占用CPU的百分比hi，软中断（Software Interrupts）占用CPU的百分比si
# %Cpu(s):  0.4 us,  0.1 sy,  0.0 ni, 98.7 id,  0.0 wa,  0.8 hi,  0.1 si,  0.0 st
# 物理内存总量，使用中的内存总量，空闲内存总量，缓存的内存量
# MiB Mem :   5810.0 total,   2592.9 free,   1994.9 used,   1222.1 buff/cache
# 交换区总量，使用的交换区总量，空闲交换区总量，缓冲的交换区总量
# MiB Swap:   4095.0 total,   4095.0 free,      0.0 used.   3550.8 avail Mem
# 按这个公式此台服务器的可用内存：18537836k +169884k +3612636k = 22GB左右。

#     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
#    2136 mysql     20   0 3408968 548548  29120 S   0.3   9.2   0:14.05 mysqld
# PID — 进程id
# USER — 进程所有者
# PR — 进程优先级
# NI — nice值。负值表示高优先级，正值表示低优先级
# VIRT — 进程使用的虚拟内存总量，单位kb。VIRT=SWAP+RES
# RES — 进程使用的、未被换出的物理内存大小，单位kb。RES=CODE+DATA
# SHR — 共享内存大小，单位kb
# S — 进程状态。D=不可中断的睡眠状态 R=运行 S=睡眠 T=跟踪/停止 Z=僵尸进程
# %CPU — 上次更新到现在的CPU时间占用百分比
# %MEM — 进程使用的物理内存百分比
# TIME+ — 进程使用的CPU时间总计，单位1/100秒
# COMMAND — 进程名称（命令名/命令行）

# 快捷键
# x 高亮
# 通过 shift + > 或 shift + < 可以向右或左改变排序列
# q 退出

# https://www.cnblogs.com/peida/archive/2012/12/24/2831353.html