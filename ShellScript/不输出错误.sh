# 屏蔽普通输出
command > /dev/null
# 屏蔽错误输出
command 2>/dev/null
# 屏蔽普通输出+错误输出
command > /dev/null 2>&1
# 注意：0是标准输入(STDIN),1是标准输出(STDOUT),2是标准错误输出(STDERR)