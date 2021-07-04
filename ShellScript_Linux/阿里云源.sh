# CentOS 7 : Base, rpmfusion, epel
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
curl -o ~/rpmfusion-free-release-7.noarch.rpm https://mirrors.aliyun.com/rpmfusion/free/el/rpmfusion-free-release-7.noarch.rpm
yum install ~/rpmfusion-free-release-7.noarch.rpm -y
rm -f ~/rpmfusion-free-release-7.noarch.rpm
curl -o /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
yum clean all
yum makecache
yum update -y

# CentOS 8 : Base, rpmfusion
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-8.repo
curl -o ~/rpmfusion-free-release-8.noarch.rpm https://mirrors.aliyun.com/rpmfusion/free/el/rpmfusion-free-release-8.noarch.rpm