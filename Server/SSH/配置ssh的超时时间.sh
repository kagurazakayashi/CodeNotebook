vim /etc/ssh/sshd_config

# 服务器每隔60s给客户端发送一次保活信息
# ClientAliveInterval 60  

# server端发出的请求客户端没有回应的次数达到x次的时候就断开连接，正常情况下客户端都会响应
# ClientAliveCountMax 7200

# 临时：
ssh -o ServerAliveInterval=60