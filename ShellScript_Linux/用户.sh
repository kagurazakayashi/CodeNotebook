# Linux 用户

# 创建用户，不创建用户文件夹
useradd yashi

# 创建用户并创建用户文件夹
adduser yashi
# 或
useradd -m yashi

# 设置某个用户的密码
passwd yashi

# 删除用户，不删除用户文件夹
userdel yashi
# 删除用户并删除用户文件夹
userdel -r yashi

# 创建时指定用户目录和shell
useradd -d "/home/tt" -m -s "/bin/bash" tt
# -d /home/tt 就是指定/home/tt为主目录
# -m 就是如果/home/tt不存在就强制创建
# -s 就是指定shell版本

# 相关文件
cat /etc/passwd # 使用者帐号资讯，可以查看用户信息
cat /etc/shadow # 使用者帐号资讯加密
cat /etc/group # 群组资讯
cat /etc/default/useradd # 定义资讯
cat /etc/login.defs # 系统广义设定
ls /etc/skel # 内含定义档的目录

# Linux 用户组

# 添加用户组
groupadd group1
grep "group1" /etc/group
# 删除用户组
groupdel group1
grep "group1" /etc/group /etc/gshadow
# 把组名group1修改为testgrp
groupmod -n testgrp group1
grep "testgrp" /etc/group

# 用户 aaa 和 bbb 加入group1群组
gpasswd -a aaa group1
gpasswd -a bbb group1
# 加入某个群组并退出之前的所有群组
usermod -G group2 aaa
grep "group2" /etc/group

# 创建用户时就设定用户组
# 创建一个用户 user1，同时指定 user1 的初始组为 group1，附加组为 group2 和 group3
useradd -g group1 -G group2,group3 user1
# 由于指定了初始组，因此不会在创建 user1 默认群组
more /etc/group | grep user1

# 用户组配置文件
vi /etc/group

# 综合
useradd -g www -m yashi
passwd yashi

chown yashi:www /www
chmod 770 /www