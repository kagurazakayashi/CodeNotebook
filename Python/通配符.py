# 0.摘要
# 在Linux Shell中，我们可以用ls *.py的命令显示所有以.py结尾的文件或文件夹。在python中我们可以借助fnmatch模块，实现含通配符的字符串匹配。

# 1.常用通配符
# 符号	作用
# *	匹配任何字符串／文本，包括空字符串； *代表任意字符（0个或多个） ls file *
# ?	匹配任何一个字符（不在括号内时）? 代表任意1个字符 ls file 0
# [abcd]	匹配abcd中任何一个字符
# [a-z]	表示范围a到z，表示范围的意思 [] 匹配中括号中任意一个字符 ls file 0
# {..}	表示生成序列. 以逗号分隔，且不能有空格
# 补充:
# [!abcd] 或 [^abcd] 表示非，表示不匹配括号里面的任何一个字符

# 2.fnmatch模块
from fnmatch import fnmatchcase as match
from fnmatch import fnmatch, fnmatchcase
print(fnmatch('foo.txt', '*.txt'))  # True
print(fnmatch('foo.txt', '?oo.txt'))  # True
addresses = [
    '5412 N CLARK ST',
    '1060 W ADDISON ST',
    '1039 W GRANVILLE AVE',
    '2122 N CLARK ST',
    '4802 N BROADWAY',
]
a = [addr for addr in addresses if match(addr, '* ST')]
print(a)
# ['5412 N CLARK ST', '1060 W ADDISON ST', '2122 N CLARK ST']
b = [addr for addr in addresses if match(addr, '54[0-9][0-9] *CLARK*')]
print(b)
#['5412 N CLARK ST']
