# docker firewalld允许容器间通信
# 允许内网段
firewall-cmd --permanent --zone=docker --add-source=172.17.0.0/16
firewall-cmd --permanent --zone=docker --add-source=172.18.0.0/16
# 撤销
firewall-cmd --permanent --zone=docker --remove-source=172.18.0.0/16
# 应用
systemctl stop docker && systemctl stop firewalld && systemctl start firewalld && systemctl start docker
