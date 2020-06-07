# python中对文件、文件夹操作时经常用到的os模块和shutil模块常用方法。

# 1.得到当前工作目录，即当前Python脚本工作的目录路径: 
os.getcwd()

# 2.返回指定目录下的所有文件和目录名:
os.listdir()

# 3.函数用来删除一个文件:
os.remove()

# 4.删除多个目录：
os.removedirs(r"c:\\python")

# 5.检验给出的路径是否是一个文件：
os.path.isfile()

# 6.检验给出的路径是否是一个目录：
os.path.isdir()

# 7.判断是否是绝对路径：
os.path.isabs()

# 8.检验给出的路径是否真地存:
os.path.exists()

# 9.返回一个路径的目录名和文件名:
os.path.split()
# eg os.path.split(‘/home/swaroop/byte/code/poem.txt’) 结果：(‘/home/swaroop/byte/code’, ‘poem.txt’)

# 10.分离扩展名：
os.path.splitext()

# 11.获取路径名：
os.path.dirname()

# 12.获取文件名：
os.path.basename()

# 13.运行shell命令: 
os.system()

# 14.读取和设置环境变量:
os.getenv() #与
os.putenv()

# 15.给出当前平台使用的行终止符:
os.linesep
# Windows使用’\r\n’，Linux使用’\n’而Mac使用’\r’

# 16.指示你正在使用的平台：
os.name
# 对于Windows，它是’nt’，而对于Linux/Unix用户，它是’posix’

# 17.重命名：
os.rename(old， new)

# 18.创建多级目录：
os.makedirs(r“c：\python\test”)

# 19.创建单个目录：
os.mkdir(“test”)

# 20.获取文件属性：
os.stat(file)

# 21.修改文件权限与时间戳：
os.chmod(file)

# 22.终止当前进程：
os.exit()

# 23.获取文件大小：
os.path.getsize(filename)

# https://blog.csdn.net/silentwolfyh/article/details/74931123