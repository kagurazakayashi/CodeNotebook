# Linux用户登录2
yum install figlet sensors -y
# 用户登录进去后显示一些信息
vim /etc/profile
# zsh
vim ~/.zshrc
# 如果使用 [登录ssh自动进入tmux.sh] 则在 export TERM=xterm 之前加
# LoginInfo
CNAME=`uname -n`
echo "======== $CNAME ========"
df -hl
ps -fa
# sensors
figlet -c $CNAME
figlet -c $USER
date
# (普通用户用 ps -f 不显示root的)