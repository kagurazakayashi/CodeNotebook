TITLE 修复LocalSend套接字没有权限
ECHO System.Net.Sockets.SocketException (10013): 以一种访问权限不允许的方式做了一个访问套接字的尝试

ECHO 哪些端口无法使用
netsh interface ipv4 show excludedportrange protocol=tcp

ECHO 把winnat关闭再开启一次(管理员权限)
net stop winnat
netsh interface ipv4 show excludedportrange protocol=tcp
net start winnat
netsh interface ipv4 show excludedportrange protocol=tcp
