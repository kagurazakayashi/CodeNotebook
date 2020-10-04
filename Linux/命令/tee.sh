# tee 1个标准输入 2个标准输出
# stdin -> a.out -> stdout -> [tee] -> stdin -> a.out -> stdout
#                                   -> stdin -> a.out -> stdout

# ls 的输出 有一份通过 tee 输出给了 ls.txt，另一份输出给了 grep：
ls /usr/bin | tee ls.txt | grep zip