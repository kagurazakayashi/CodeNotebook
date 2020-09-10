#yum代理
vim /etc/yum.conf
proxy=http://192.168.2.100:23331
proxy_username=代理服务器用户名
proxy_password=代理服务器密码

# RHEL8 Updating Subscription Management repositories.
vim /etc/rhsm/rhsm.conf
# an http proxy server to use
proxy_hostname =
# port for http proxy server
proxy_port = 

systemctl restart tinyproxy