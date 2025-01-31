# Linux用户登录1
# 安装 tmux
yum install tmux -y

vim /etc/profile
# 如果还需要 vscode 远程，改当前用户的：
vim ~/.bashrc
vim ~/.zshrc
# tmux
export TERM=xterm
# 不过不止 SSH 用则去掉 && [ "$SSH_CONNECTION" != "" ]
if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
tmux has 2> /dev/null || tmux new-session -s "$USER" && tmux attach
exit
fi