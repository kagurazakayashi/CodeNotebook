# 显示正在进行中的后台程序
jobs
# [1]+  Running      ./noend.out   正在运行
# [2]+  Stopped      ./noend.out   暂停（挂起）
# [2]+  Terminated   ./noend.out   终止
jobs -l
# 作业号 进程号 状态
# [1]+  3499 Running ./noend.out

# jobs [option] [%jobid]
# -l 显示进程的 ID 和状态
# + 当前作业
# - 前一个作业