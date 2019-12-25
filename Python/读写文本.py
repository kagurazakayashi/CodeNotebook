#coding:utf-8
'''cdays-4-exercise-6.py 文件基本操作
    @note: 文件读取写入, 列表排序, 字符串操作
    @see: 字符串各方法可参考hekp(str)或Python在线文档http://docs.python.org/lib/string-methods.html
'''

f = open('cdays-4-test.txt', 'r')                   #以读方式打开文件
result = list()
for line in f.readlines():                          #依次读取每行
    line = line.strip()                             #去掉每行头尾空白
    if not len(line) or line.startswith('#'):       #判断是否是空行或注释行
        continue                                    #是的话，跳过不处理
    result.append(line)                             #保存
result.sort()                                       #排序结果
print result
open('cdays-4-result.txt', 'w').write('%s' % '\n'.join(result)) #保存入结果文件



# 假设 sxl.txt文件内容如下：

# i like the movie
# i ate an egg

# read（）方法
# 表示一次读取文件全部内容，该方法返回字符串。
f = open("sxl.txt")
lines = f.read()
print lines
print(type(lines))
f.close()
# 输出结果：
# i like the movie
# i ate an egg
# <class 'str'>

# readline（）方法
# 该方法每次读出一行内容，所以，读取时占用内存小，比较适合大文件，该方法返回一个字符串对象。
f = open("sxl.txt")
line = f.readline()
while line:
    print (line)
    print(type(line))
    line = f.readline()
f.close()
# 输出结果：
# i like the movie
# <class 'str'>
# i ate an egg
# <class 'str'>

# readlines（）方法
# readlines()方法读取整个文件所有行，保存在一个列表(list)变量中，每次读取一行，但读取大文件会比较占内存。
f = open("sxl.txt")
lines = f.readlines()
for line in lines:
    print (line)
    print(type(line))
f.close()
# 输出结果：
# i like the movie
# <class 'str'>
# i ate an egg
# <class 'str'>

# 最后还有一种方式，与第三种方法类似。
f = open("sxl.txt")
print (type(f))
for line in f:
    print (line)
    print(type(line))
f.close()
# 输出结果：
# <class '_io.TextIOWrapper'>
# i like the movie
# <class 'str'>
# i ate an egg
# <class 'str'>

# https://zhuanlan.zhihu.com/p/42784651
# https://www.jianshu.com/p/a672f39287c4