# find和mv的结合使用：查找文件，移动到某个目录
# 把当前目录下面的file（不包括目录)，移动到/opt/shell
find . -type f -exec mv {}  /opt/shell  \;
find . -type f | xargs -I '{}' mv {} /opt/shell

#
find ./ -name "*2022*" -exec mv {} /www/wwwlogs/2022 \;
find . -name .svn -exec rm -rvf {} \;
