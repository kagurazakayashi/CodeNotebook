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