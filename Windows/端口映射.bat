#设置
netsh interface portproxy add v4tov4 listenport=80 listenaddress=127.0.0.1 connectport=8081 connectaddress=127.0.0.2
#显示
netsh interface portproxy show v4tov4
#删除
netsh interface portproxy del v4tov4 listenport=80 listenaddress=127.0.0.1
