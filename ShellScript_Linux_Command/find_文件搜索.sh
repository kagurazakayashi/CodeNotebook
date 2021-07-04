# find 按照指定信息，对指定目录进行文件搜索
# find <路径> <选项> [-print -exec -ok]
# <路径> 开始搜索文件的路径
# -name 指定文件名
# -perm 按照文件权限查找文件
# -user 按照文件属主查找文件
# -group 按照文件所属组查找文件
# -mtime -n +n 按照文件的更改时间查找文件
#     -n 表示文件更改时间距现在n天以内
#     +n 表示文件更改时间距现在n天以前
# -atime -ctime 和 -mtime 相似
# -nogroup 查找无有效所属组文件，即该文件所属的组在 /etc/group 中不存在
# -nouser 查找无有效所属用户文件，即该文件所属用户在 /etc/passwd 中不存在
# -newer file1 ! file2 查找更改时间比文件 file1 新但比 file2 旧的文件
# -type 查找某一类型的文件：
#     b - block 块设备文件
#     d - directory 目录
#     c - character 字符设备文件
#     p - pipe 管道文件
#     l - link 符号链接文件
#     f - file 普通文件
# -size n[c] 查找文件长度为n块的文件，带有c时表示文件长度以字节计
# -depth 在查找文件时，首先查找当前目录中的文件，然后再子目录中查找
# -fstype 查找位于某一类型文件系统中的文件，这些文件系统类型通常可以在配置文件 /etc/fstab 中找到，该配置文件中包含了本系统中有关文件系统的信息
# -mount 在查找文件时不跨越文件系统 mount 点
# -follow 如果 find 命令遇到符号链接文件，就跟踪至链接所指向的文件
# -cpio 对匹配文件使用 cpio 命令，将这些文件备份到磁带设备中
# -print 搜索结果的文件输出到标准输出
# -exec 对搜索结果的文件执行指定的 Shell 命令，格式为 'command' {} \;
# -ok 对搜索结果的文件执行指定的 Shell 命令，每次提示用户执行

# 包含通配符的的文件名要用引号
find /bin -name '*rm*' -print

# 查找子目录 /usr/bin 中最近 100 天没有使用过的程序
find /usr/bin -type f -atime +100 -print

# 在子目录 /usr/bin 中查找建立不到1天的新文件或者1天内修改过的文件
find /usr/bin -type f -mtime -1 -print

# 搜索用户ID是503的文件，输出到标准输出，删除这些文件。
find / -type f -uid 503 -print -exec rm {} \;

# 在当前目录下查找文件权限为755的文件
find . -perm 755 -print

# 在当前目录下查找所有用户都可读、写、执行的文件，在权限位数字前面加-
find . -perm -007 -print

# 在 $HOME 目录中查找文件所属用户为 yashi 的文件
find ~ -user yashi -print


# 在当前目录下搜索指定文件
find . -name test.txt

# 在当前目录下模糊搜索文件
find . -name '*.txt'

# 在当前目录下搜索特定属性的文件
find . -amin -10 # 查找在系统中最后10分钟访问的文件
find . -atime -2 # 查找在系统中最后48小时访问的文件
find . -empty # 查找在系统中为空的文件或者文件夹
find . -group cat # 查找在系统中属于 groupcat的文件
find . -mmin -5 # 查找在系统中最后5分钟里修改过的文件
find . -mtime -1 #查找在系统中最后24小时里修改过的文件
find . -nouser #查找在系统中属于作废用户的文件
find . -user fred #查找在系统中属于FRED这个用户的文件

# 在当前目录搜索文件内容含有某字符串（大小写敏感）的文件
find . -type f | xargs grep 'your_string'

# 在当前目录搜索文件内容含有某字符串（大小写敏感）的特定文件
find . -type f -name '*.sh' | xargs grep 'your_string'

# 在当前目录搜索文件内容含有某字符串（忽略大小写）的特定文件
find . -type f -name '*.sh' | xargs grep -i 'your_string'

# 查找大文件
find / -type f -size +100M 2>/dev/null