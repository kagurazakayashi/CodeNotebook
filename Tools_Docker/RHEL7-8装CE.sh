yum remove docker*
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://mirrors.ustc.edu.cn/docker-ce/linux/centos/docker-ce.repo
wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
rpm -ivh epel-release-latest-8.noarch.rpm
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce
# package docker-ce-3:19.03.3-3.el7.x86_64 requires containerd.io >= 1.2.2-3
# yum install containerd.io docker-ce --nobest
docker --version
systemctl restart docker
systemctl enable docker

# 阿里云源
https://yq.aliyun.com/articles/110806
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
# 一键脚本
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun

# 添加当前用户到用户组
groupadd docker
usermod -aG docker yashi