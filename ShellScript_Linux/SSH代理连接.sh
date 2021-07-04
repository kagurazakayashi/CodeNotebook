sudo apt install netcat connect-proxy -y

# 通过代理连接SSH
ssh -o "ProxyCommand=nc -X connect -x PROXYHOST:PROXYPORT %h %p" #...

# 如果显示 nc: invalid option -- X
ssh -o ProxyCommand="connect-proxy -S PROXYHOST:PROXYPORT %h %p" #...

# 在 ~/.ssh/config 设定的话：

# Host aaa
#     ProxyCommand          nc -X connect -x proxyhost:proxyport %h %p
#     ServerAliveInterval   10

ssh aaa