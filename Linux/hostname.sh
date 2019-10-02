# 如果只是修改hostname可以通过如下命令
hostname newHostname
# 如果需要永久修改hostname可通过如下命令
vi /etc/sysconfig/network
# Redhat / CentOS / Fedora系列
vi /etc/sysconfig/network
# Debian / Ubuntu系列
vi /etc/hostname
# 修改其中的HOSTNAME项，不过此种方法需要重启后生效。
HOSTNAME=yourhostname
# 查看设置后的hostname
hostname