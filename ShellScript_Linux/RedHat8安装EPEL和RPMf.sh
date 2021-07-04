# Installing EPEL Repository on RHEL 8.x
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y

# Install a Package from the EPEL Repository on RHEL 8
dnf --enablerepo="epel" install <package_name>

# rpmfusion
dnf -y install https://download.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
dnf localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm
dnf install --nogpgcheck https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-8.noarch.rpm
# aliyun
dnf install https://mirrors.aliyun.com/rpmfusion/free/el/rpmfusion-free-release-8.noarch.rpm -y
dnf install https://mirrors.aliyun.com/rpmfusion/nonfree/el/rpmfusion-nonfree-release-8.noarch.rpm -y