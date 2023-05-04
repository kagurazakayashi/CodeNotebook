# 修改文件或目录所属的用户：
chown mysql mysql.log
# 修改文件或目录所属的组：
chgrp mysql mysql.log

# 查看linux文件的权限：
ls -l 文件名称
# 查看linux文件夹的权限：
ls -ld 文件夹名称（所在目录）

# 修改文件及文件夹权限：
chmod 600 ... #（只有所有者有读和写的权限 -rw------- ）
chmod 644 ... #（所有者有读和写的权限，组用户只有读的权限 -rw-r--r-- ）
chmod 700 ... #（只有所有者有读和写以及执行的权限 -rwx------ ）
chmod 666 ... #（每个人都有读和写的权限 -rw-rw-rw- ）
chmod 777 ... #（每个人都有读和写以及执行的权限 -rwxrwxrwx ）

# 其中a,b,c各为一个数字，分别表示User、Group、及Other的权限。
# r=4，w=2，x=1
# 若要rwx属性则4+2+1=7；
# 若要rw-属性则4+2=6；
# 若要r-x属性则4+1=7。

chmod 777 file
# 等于
chmod a=rwx file

chmod ug=rwx,o=x file
# 等于
chmod 771 file