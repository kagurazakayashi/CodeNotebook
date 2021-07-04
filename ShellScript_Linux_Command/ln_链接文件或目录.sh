# ln -s 源文件(已有) 目标文件(新建)。
ln -s /usr/local/imagemagick/bin/convert /usr/local/bin/convert
ln -s /usr/local/imagemagick/bin/identify /usr/local/bin/identify
# 不论是硬连结或软链结都不会将原本的档案复制一份，只会占用非常少量的磁碟空间。
# 　　-f : 链结时先将与 dist 同档名的档案删除
# 　　-d : 允许系统管理者硬链结自己的目录
# 　　-i : 在删除与 dist 同档名的档案时先进行询问
# 　　-n : 在进行软连结时，将 dist 视为一般的档案
# 　　-s : 进行软链结(symbolic link)
# 　　-v : 在连结之前显示其档名
# 　　-b : 将在链结时会被覆写或删除的档案进行备份
# 　　-S SUFFIX : 将备份的档案都加上 SUFFIX 的字尾
# 　　-V METHOD : 指定备份的方式
# 　　--help : 显示辅助说明
# 　　--version : 显示版本

# https://www.cnblogs.com/kex1n/p/5193826.html


# 硬链接（hard links）和符号链接（symbolic links）
# 硬链接把文件名直接链接到文件系统上的一个已存在的文件。
# 硬链接可以理解为创建了一个文件的别名。
# 一个文件可以有多个硬链接。
# 符号链接用来在扩展到不同的文件系统上的子目录或者文件之间建立链接。

# 硬链接可以一个文件建立多个名字。
# 只有一个物理文件存在。
# 可以通过任何一个硬链接访问文件。
# 要删除文件，必须删除所有的硬链接。
# 不可以建立目录的硬链接。

# 硬链接（hard links）（同一个文件，修改的话，修改日期和内容等都跟着变）
ln <已有文件> <新的链接文件>
# 符号链接（symbolic links）（快捷方式文件）
ln -s <已有文件> <新建符号链接文件>

# 建立目录符号链接
ln -s <已有目录> <新建目录符号链接文件>