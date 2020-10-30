# 顺序执行命令
# 在一个命令行上顺序执行命令
pwd; date; whoami

# 并行执行命令
# 在一个命令行上并行执行多个命令。
# 并行执行的命令是后台命令。
pwd& date& whoami&

# 命令组
# 多个命令在一个进程中执行。
(pwd; date; whoami)