subscription-manager register --username=用户名  --password=密码  --auto-attach

# 取消
subscription-manager remove --all
subscription-manager unregister
subscription-manager clean

# RHEL8 Subscription Management
/etc/rhsm/rhsm.conf
# an http proxy server to use
proxy_hostname =
# port for http proxy server
proxy_port = 

# 网页管理注册
https://access.redhat.com/management/products