# coding:utf-8
# 一、os模块
import os

# 1、os.system(cmd)
# 在子终端运行系统命令，不能获取命令执行后的返回信息以及执行返回的状态
os.system('date')
# 2016年 06月 30日 星期四 19:26:21 CST

# 2、os.popen(cmd)
# 不仅执行命令而且返回执行后的信息对象(常用于需要获取执行命令后的返回信息)
nowtime = os.popen('date')
print nowtime.read()
# 2016年 06月 30日 星期四 19:26:21 CST

# 二、commands模块
# getoutput 获取执行命令后的返回信息
# getstatus 获取执行命令的状态值(执行命令成功返回数值0，否则返回非0)
# getstatusoutput 获取执行命令的状态值以及返回信息
import commonds
status, output = commands.getstatusoutput('date')
print status    # 0
print output    # 2016年 06月 30日 星期四 19:26:21 CST

# 三、subprocess模块
# 运用对线程的控制和监控，将返回的结果赋于一变量，便于程序的处理。官方文档：http://python.usyiyi.cn/python_278/library/subprocess.html
import subprocess
nowtime = subprocess.Popen('date', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
print nowtime.stdout.read()
# 2016年 06月 30日 星期四 19:26:21 CST

# https://blog.csdn.net/luckytanggu/java/article/details/51793218