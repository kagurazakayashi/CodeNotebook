# 日常编写调试运行程序过程中，难免需要手动停止，以下两种方法可以捕获ctrl+c立即停止程序

# 1、使用python的异常KeyboardInterrupt
try:
    while 1:
        pass
except KeyboardInterrupt:
    pass

# 2、使用signal模块
import signal
def exit(signum, frame):
    print('You choose to stop me.')
    exit()
signal.signal(signal.SIGINT, exit)
signal.signal(signal.SIGTERM, exit)
while 1:
    pass