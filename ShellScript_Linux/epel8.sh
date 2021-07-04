ls /etc/yum.repos.d/

dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y

# 代理下载
wget --no-check-certificate https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -e use_proxy=yes -e http_proxy=192.168.2.100:23331

# tuna
# https://mirrors.tuna.tsinghua.edu.cn/help/epel/

# RPM Fusion
# https://rpmfusion.org/Configuration
# https://mirrors.tuna.tsinghua.edu.cn/help/rpmfusion/