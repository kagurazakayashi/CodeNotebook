# 查看用户
cat /etc/passwd

# 查看用户组
cat /etc/group

# 查看当前活跃的用户列表
w

#对于 cat /etc/passwd 的替换
cat /etc/passwd|grep -v nologin|grep -v halt|grep -v shutdown|awk -F":" '{ print $1"|"$3"|"$4 }'|more
# root|0|0
# test|1000|1000