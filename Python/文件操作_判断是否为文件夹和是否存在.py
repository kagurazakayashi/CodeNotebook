# 判断是否为文件夹
import os
if os.path.isdir(path):
    print "it's a directory"
elif os.path.isfile(path):
    print "it's a normal file"
else:
    print "it's a special file(socket,FIFO,device file)"

# 判断文件，文件夹是否存在
import os
os.path.exists('c:/assist') # True
os.path.exists('c:/assist/1.txt') # True