yum install xorg-x11-xauth xorg-x11-apps -y

vim /etc/ssh/sshd_config
- `AllowTcpForwarding yes`
- `X11Forwarding yes`
/etc/init.d/sshd restart

ssh 连接时加 -X 参数 开启转发 （可能需要 -Y ）

远程 Linux 设置环境变量
`export DISPLAY=本地主机地址:0.0`