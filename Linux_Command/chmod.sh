# 更改用户文件的权限 change mode
# 使用命令 chmod 更改文件的权限。
# chmod {a,u,g,o} {+,-} {r,w,x} <filename>

# {a,u,g,o}
# a 所有用户
# u 当前用户
# g 同组用户
# o 用户组以外的其他用户

# {+,-}
# + 添加访问权
# - 去掉访问权

# {r,w,x}
# r 可读
# w 可写
# x 可执行

# <filename>
# 表示指定的文件名

# 把 -rw-r--r-- 改成 -rw-rw-r-- (给同组用户开放可写权限)
chmod g+w hello.txt # group同组用户 + writable可写
# 把 -rw-rw-r-- 改成 -rwxrw-r-- (当前用户可以运行)
chmod u+x hello.txt
# 让其他用户也可以写入 -rwxrw-rw-
chmod o+x hello.txt
# 所有用户去掉写权限 -r-xr--r--
chmod a-w hello.txt

# 用数字表示权限：如果有权限就用 1 表示，没有权限用 0 表示

# 字母码 - r - x  r - -  r - -
# 二进制  1 0 1  1 0 0  1 0 0
# 十进制    5      4      4
chmod 544 hello.txt

# 字母码 - r w -  r - -  r - -
# 二进制   1 1 0  1 1 0  1 1 0
# 十进制     6      6      6
chmod 666 hello.txt