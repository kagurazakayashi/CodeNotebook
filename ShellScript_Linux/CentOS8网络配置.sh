# CentOS 8 网络设置
# 网络配置文件：
​cat /etc/sysconfig/network-scripts/eno0
# 自动连接：
# ONBOOT=no   =>  ONBOOT=yes
# 网络服务：
​​systemctl restart NetworkManager.service

# 方法二：RHEL8和CentOS8完全使用nmcli来管理网络​

# http://mirrors.aliyun.com/centos/8.2.2004/BaseOS/x86_64/os/Packages/centos-release-8.2-2.2004.0.1.el8.x86_64.rpm