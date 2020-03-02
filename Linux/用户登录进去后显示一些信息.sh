# 用户登录进去后显示一些信息
vim /etc/profile
# 如果使用 登录ssh自动进入tmux.sh 则在 export TERM=xterm 之前加
CNAME="Yashi ECS"
echo "======== $CNAME ========"
df -hl
ps -fa
figlet -c $CNAME
date
echo "Welcome," `logname` "."
#(普通用户用 ps -f 不显示root的)