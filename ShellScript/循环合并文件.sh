# 循环合并文件

find . -type f -exec cat {} \;>all_files.txt

# find . 递归从本文件夹开始查找文件

# -type f 指定文件类型为普通文件，还可以选用的项有：d 目录、l 链接符号、c 字符设备、b 块设备、s 套接字等

# -amin/-mmin/-cmin 可以指定文件的访问时间/修改时间/改变时间。e.g. find . -type f -atime +7 -print 打印出访问时间超过七天的所有文件

# -perm 根据文件权限查找文件

# -user 更具文件所有者查找文件

# -delete 将删除查找到的文件

# -exec 对查找到的文件执行命令，格式为： -exec ./commands.sh {} \;
