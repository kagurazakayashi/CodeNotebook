#coding:utf-8
import os

os.path.split(os.path.realpath(__file__))[0]

# C:test
# |-getpath
#     |-path.py
#     |-sub
#         |-sub_path.py
# 然后我们在C:\test下面执行python getpath/path.py，这时sub_path.py里面与各种用法对应的值其实是：

os.getcwd() #“C:\test”，取的是起始执行目录

sys.path[0]或sys.argv[0] #“C:\test\getpath”，取的是被初始执行的脚本的所在目录

os.path.split(os.path.realpath(__file__))[0] #“C:\test\getpath\sub”，取的是file所在文件sub_path.py的所在目录

# https://blog.csdn.net/vitaminc4/article/details/78702852