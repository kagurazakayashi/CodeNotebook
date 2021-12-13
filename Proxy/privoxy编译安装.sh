# 安装编译工具和依赖
yum install make gcc autoconf zlib zlib-devel -y
# 下载 https://www.silvester.org.uk/privoxy/Sources/
wget https://www.silvester.org.uk/privoxy/Sources/3.0.33%20%28stable%29/privoxy-3.0.33-stable-src.tar.gz
tar -zxf privoxy-3.0.33-stable-src.tar.gz
cd privoxy-3.0.33-stable-src
# 编译和创建用户
autoheader
autoconf
./configure --prefix=/usr/local/privoxy
make
useradd privoxy -r -s /usr/sbin/nologin
make install
# 查看编译后的生成文件
ll /usr/local/
ll /usr/local/privoxy/
ll /usr/local/privoxy/sbin/
ll /usr/local/privoxy/etc/
# 配置 privoxy
vim /usr/local/privoxy/etc/config
# 配置监听和转发，找到 listen-address 
listen-address 127.0.0.1:8118
forward-socks5 / 127.0.0.1:1080 .
# 创建系统服务
vim /etc/systemd/system/privoxy.service
# [Unit]
# Description=Privoxy Web Proxy With Advanced Filtering Capabilities
# Wants=network-online.target
# After=network-online.target
# [Service]
# Type=forking
# PIDFile=/run/privoxy.pid
# ExecStart=/usr/local/privoxy/sbin/privoxy --pidfile /run/privoxy.pid --user privoxy /usr/local/privoxy/etc/config
# [Install]
# WantedBy=multi-user.target

systemctl daemon-reload
systemctl enable privoxy
systemctl start privoxy
systemctl status privoxy

# 放行相关端口
firewall-cmd --zone=public --add-port=8118/tcp --permanent
firewall-cmd --reload