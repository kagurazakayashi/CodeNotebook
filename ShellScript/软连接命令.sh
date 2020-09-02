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