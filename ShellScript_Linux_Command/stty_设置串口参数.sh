# stty_设置串口参数

# 设置波特率
# 标准速度
stty -F /dev/ttyS0 9600
# Prolific PL2303GS USB Serial COM Port (绿联USB转RS232母)
# 10M 传输最大稳定速度 806400 , stty 最相近支持速度 460800
stty -F /dev/ttyUSB0 460800

# 设置数据位
stty -F /dev/ttyUSB0 cs8

# 设置校验位
# 无校验：-parenb
stty -F /dev/ttyUSB0 -parenb
# 奇校验：parenb parodd
stty -F /dev/ttyUSB0 parenb parodd
# 偶校验：parenb -parodd
stty -F /dev/ttyUSB0 parenb -parodd

# 设置停止位
# 1 个停止位：-cstopb
stty -F /dev/ttyUSB0 -cstopb
# 2 个停止位：cstopb
stty -F /dev/ttyUSB0 cstopb

# 设置流控 (流控可能导致信息不完整)
# 禁用硬件流控：-crtscts
stty -F /dev/ttyUSB0 -crtscts
# 启用硬件流控：crtscts
stty -F /dev/ttyUSB0 crtscts
# 禁用软件流控：-ixon -ixoff
stty -F /dev/ttyUSB0 -ixon -ixoff
# 启用软件流控：ixon ixoff
stty -F /dev/ttyUSB0 ixon ixoff
