#!/usr/local/bin/python
# -*- coding:utf-8 -*-

import sys

print(sys.argv[0])          #sys.argv[0] 类似于shell中的$0,但不是脚本名称，而是脚本的路径
print(sys.argv[1])          #sys.argv[1] 表示传入的第一个参数，既 hello

#运行结果：
# python /opt/python.py hello
# /opt/python.py       #打印argv[0]  脚本路径
# hello                #打印argv[1]  传入的参数 hello
