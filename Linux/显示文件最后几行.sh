# 监视filename文件的尾部内容（默认10行，相当于增加参数 -n 10），刷新显示在屏幕上。退出，按下CTRL+C。
tail -f filename

# 显示filename最后20行。
tail -n 20 filename

# 显示filename前面20行。
tail -n +20 filename

# 逆序显示filename最后10行。
tail -r -n 10 filename

# 跟tail功能相似的命令还有：
cat #从第一行开始显示档案内容。
tac #从最后一行开始显示档案内容。
more #分页显示档案内容。
less #与 more 相似，但支持向前翻页
head #仅仅显示前面几行
tail #仅仅显示后面几行
n #带行号显示档案内容
od #以二进制方式显示档案内容