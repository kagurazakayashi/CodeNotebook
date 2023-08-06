# Debian12安装MySQL
# https://dev.mysql.com/downloads/repo/apt/
wget https://dev.mysql.com/get/mysql-apt-config_0.8.26-1_all.deb
apt install ./mysql-apt-config_0.8.26-1_all.deb
apt install mysql-community-server -y
apt install mysql-community-client -y

# Debian12安装MySQL时报错缺少依赖libssl1.1(>= 1.1.1)
wget https://mirrors.tuna.tsinghua.edu.cn/debian/pool/main/o/openssl/libssl1.1_1.1.1n-0%2Bdeb11u5_amd64.deb
dpkg -i libssl1.1_1.1.1n-0+deb11u5_amd64.deb
