# 激活红帽订阅
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
# https://access.redhat.com/management/products

# 刷新订阅状态
subscription-manager refresh
# This system is registered to Red Hat Subscription Management, but is not receiving updates. You can use subscription-manager to assign subscriptions.
subscription-manager attach --auto
# 已安装的产品的当前状态：
# 产品名称： Red Hat Enterprise Linux for x86_64
# 状态：     已订阅
yum makecache