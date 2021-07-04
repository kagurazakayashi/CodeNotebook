kill -9 `ps -ef|grep helloworld|awk '{print $2}'`

ps -efww|grep -w 'helloworld'|grep -v grep|cut -c 9-15|xargs kill -9

# 说明：管道符“|”用来隔开两个命令，管道符左边命令的输出会作为管道符右边命令的输入。 

# “ps　-efww”是查看所有进程的命令。这时检索出的进程将作为下一条命令“grep“的输入，注意要结束其它程序时，请将上面命令中的helloworld替换成其它程序名，-w 'helloworld' 强制 PATTERN 仅完全匹配字词。

# “grep -v grep”是在列出的进程中去除含有关键字“grep”的进程。

# “cut -c 9-15”是截取输入行的第9个字符到第15个字符，而这正好是进程号PID。

# “xargs kill -9”中的xargs命令是用来把前面命令的输出结果（PID）作为“kill -9”命令的参数，并执行该命令。

# “kill -9”会强行杀掉指定进程，这样就成功清除了同名进程。