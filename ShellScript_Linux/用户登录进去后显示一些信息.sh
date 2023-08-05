# Linux用户登录2
yum install figlet -y
# 用户登录进去后显示一些信息
vim /etc/profile
# zsh
vim ~/.zshrc
# 如果使用 [登录ssh自动进入tmux.sh] 则在 export TERM=xterm 之前加
# LoginInfo
CNAME="Yashi ECS"
echo "======== $CNAME ========"
df -hl
ps -fa
# sensors
figlet -c $CNAME
date
echo "Welcome," `logname` "."
# (普通用户用 ps -f 不显示root的)