# 提供了三种发法实现遍历文件夹下的所有文件。
# 分别是利用os模块下面的listdir，scandir，walk方法实现。
# 具体代码如下

import os
import sys

# print("path:",sys.path)

print("当前路径1(带文件名):", sys.argv[0])
print("当前路径2:", sys.path[0])
print("当执行文件夹名称:", os.path.dirname(sys.argv[0]))
print("当执行文件名称:", os.path.basename(sys.argv[0]))

print("===========================")
print("遍历文件夹")

dirpath = sys.path[0]
for root, dirs, names in os.walk(dirpath):
    for filename in names:
        print(root, filename)

print("利用os.listdir。遍历文件夹下的所有文件，不能进入子文件夹")
listdir = os.listdir(dirpath)
for name in listdir:
    print(name)

print("利用os.scandir可以遍历文件夹下的文件和文件夹")
scadndir = os.scandir(dirpath)
for name in scadndir:
    if name.is_dir():
        print("dirpath:", name.path)
    else:
        print("filename:", name.name)

print("2利用os.scandir可以遍历文件夹下的文件和文件夹的实现")
# print("dirpath:",dirpath)


def scandir(path):
    for name in os.scandir(path):
        if name.is_dir():
            print("dirpath:", name.path)
            scandir(name.path)
        else:
            print("filename:", name.name)


# 函数调用
scandir(dirpath)

# os.walk()

print("os.walk-------------\n")
for root, dirs, files in os.walk(dirpath):
    print(root)
    print(dirs)
    print(files)

input()

# https://blog.csdn.net/chyuanrufeng/article/details/103035568
