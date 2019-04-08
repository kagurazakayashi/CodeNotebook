yum install tmux -y
vim "/etc/profile"
# tmux
export TERM=xterm
if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
tmux has 2> /dev/null || tmux new-session -s "$USER" && tmux attach
exit
fi