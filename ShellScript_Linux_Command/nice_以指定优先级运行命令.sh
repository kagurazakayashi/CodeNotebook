# nice 命令
# 运行程序，指定优先级的 nice 值。以指定优先级运行命令
# nice [option] [command [arg]...]
# -n nice 值，从 -20 (高优先级) 到 19 (低优先级)，缺省
nice -n -20 #（最高优先序）
nice -n 19  #（最低优先序）