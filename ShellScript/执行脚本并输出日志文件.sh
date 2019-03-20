# shell中每个进程都和三个系统文件相关联
# 标准输入stdin
# 标准输出stdout
# 标准错误stderr
# 三个系统文件的文件描述符分别为0，1和2。 
# 所以这里2>&1的意思就是将标准错误也输出到标准输出当中。

# 标准输出重定向到log文件中，标准错误打印在屏幕上
./test.sh > test1.log
# /test.sh: line 1: t: command not found
$ cat test1.log
# Tue Oct 9 20:51:50 CST 2007

# 标准输处和标准错误重定向到同一log文件中
$ ./test.sh > test2.log 2>&1
$ cat test2.log
# ./test.sh: line 1: t: command not found
# Tue Oct 9 20:53:44 CST 2007

# 标准输处和标准错误重定向到同一log文件中(追加)
./test.sh >>pp.txt 2>&1

# 标准输处和标准错误重定向到不同log文件中
sh mr_add_test.sh 1>log.log 2>log_err.log

# https://blog.csdn.net/sinat_25873421/article/details/80340049