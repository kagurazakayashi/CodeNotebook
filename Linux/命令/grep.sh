# grep 命令
# 从文件中查找匹配指定模式的文本
# grep [选项] [文本模式] [文件列表] [选项]
# -c 只输出匹配行的计数。
# -i 不区分大小写（只适用于单字符）。
# -h 查询多文件时不显示文件名。
# -l 查询多文件时只输出包含匹配字符的文件名。
# -n 显示匹配行及行号。
# -s 不显示不存在或无匹配文本的错误信息。
# -v 显示不包含匹配文本的所有行。
# [文本模式] 简单的字、短语，或正则表达式。
# [文件列表]

# 列出包含内容为 'net' 的行
grep net install.log
# 同时输出行号
grep -n net install.log

# 列出包含内容为 'Listen' ，但是不是以 '#' 开头的行
# 先把 '#' 开头的内容先去掉，然搜查找有 'Listen' 字符的行
grep -v "^#" httpd.conf | grep -n Listen
# "^#"：正则表达式

# 把命令 ls 的标准输出作为命令 grep 的标准输入。
# 显示目录 /bin | grep sh
ls -l /bin | grep sh

# 显示目录 /usr/bin 中包含 to 的行，分页显示
ls -l /usr/bin | grep "to" | more

# 在文件 file.txt 中搜索文本 "radio"
grep radio file.txt

# 在文件 file.txt 中搜索文本 "is a test"
grep "is a test" file.txt

# 在文件 /etc/passwd 中搜索文本 "yashi"
grep "yashi" /etc/passwd

# 查找在文件 data.f 中 48 出现的次数
grep -c "48" data.f
# 4

# 显示所有不包含 48 的各行
grep -v "48" data.f

# 显示包含 48 的各行的行号
grep -n "48" data.f

# 查找含有制表符的字符串
grep "48<tab>" data.f

# 忽略字母的大小写
grep -i "sept" data.f

# 在 grep 中使用规则表达式
# 查找包含 483 或 484 的行
grep '48[34]' data.f

# 查找不是以 48 开头的行
grep '^[^48]' data.f