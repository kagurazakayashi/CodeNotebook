yum install dnsmasq -y
vim /etc/dnsmasq.conf
# domain-needed
# bogus-priv
# cache-size=51200
# listen-address=172.30.10.1
# resolv-file=/etc/resolv.conf
# address=/www.aaa.com/172.30.0.101
# address=/www.bbb.com/172.30.0.102
# address=/www.ccc.com/172.30.0.103

systemctl enable dnsmasq
systemctl start dnsmasq
systemctl status dnsmasq

# nginx 反代时调用解析
resolver 172.30.0.1;