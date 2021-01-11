import os
# 2、文件操作方法大全：

# 1.创建空文件
os.mknod('test.txt')

# 2.直接打开一个文件，如果文件不存在则创建文件
fp = open('test.txt',w)

# 3.关于open 模式：
# w：以写方式打开，
# a：以追加模式打开 (从 EOF 开始, 必要时创建新文件)
# r+：以读写模式打开
# w+：以读写模式打开 (参见 w )
# a+：以读写模式打开 (参见 a )
# rb：以二进制读模式打开
# wb：以二进制写模式打开 (参见 w )
# ab：以二进制追加模式打开 (参见 a )
# rb+：以二进制读写模式打开 (参见 r+ )
# wb+：以二进制读写模式打开 (参见 w+ )
# ab+：以二进制读写模式打开 (参见 a+ )

#size为读取的长度，以byte为单位
fp.read([size])

#读一行，如果定义了size，有可能返回的只是一行的一部分
fp.readline([size])

#把文件每一行作为一个list的一个成员，并返回这个list。其实它的内部是通过循环调用readline()来实现的。如果提供size参数，size是表示读取内容的总长，也就是说可能只读到文件的一部分。
fp.readlines([size])

#把str写到文件中，write()并不会在str后加上一个换行符
fp.write(str)

#把seq的内容全部写到文件中(多行一次性写入)。这个函数也只是忠实地写入，不会在每行后面加上任何东西。
fp.writelines(seq)

#关闭文件。python会在一个文件不用后自动关闭文件，不过这一功能没有保证，最好还是养成自己关闭的习惯。 如果一个文件在关闭后还对其进行操作会产生ValueError
fp.close()

#把缓冲区的内容写入硬盘
fp.flush()

#返回一个长整型的'文件标签'
fp.fileno()

#文件是否是一个终端设备文件(unix系统中的)
fp.isatty()

#返回文件操作标记的当前位置，以文件的开头为原点
fp.tell()

#返回下一行，并将文件操作标记位移到下一行。把一个file用于for … in file这样的语句时，就是调用next()函数来实现遍历的。
fp.next()

#将文件打操作标记移到offset的位置。这个offset一般是相对于文件的开头来计算的，一般为正数。但如果提供了whence参数就不一定了，whence可以为0表示从头开始计算，1表示以当前位置为原点计算。2表示以文件末尾为原点进行计算。需要注意，如果文件以a或a+的模式打开，每次进行写操作时，文件操作标记会自动返回到文件末尾。
fp.seek(offset[,whence])

# https://blog.csdn.net/silentwolfyh/java/article/details/74931123

# 判断文件是否存在
os.path.exists('test_file.txt')

# 逐行读取文件
f = open("1.txt")
line = f.readline()
while line:
    print(line, end = '')
f.close()

# 整读并逐行
f = open("1.txt","r")
lines = f.readlines() #读取全部内容 ，并以列表方式返回
for line in lines
    print line

# 整读
file_object = open('1.txt')
try:
    all_the_text = file_object.read()
finally:
    file_object.close()

# https://blog.csdn.net/zhengxiangwen/article/details/55148287