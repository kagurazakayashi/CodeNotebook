systemctl stop docker
mkdir -p /etc/systemd/system/docker.service.d
vim /etc/systemd/system/docker.service.d/http-proxy.conf
# [Service]
# Environment="HTTP_PROXY=http://127.0.0.1:1081/"
systemctl daemon-reload
systemctl show --property=Environment docker
systemctl start docker


# docker代理
# https://docs.docker.com/config/daemon/systemd/#httphttps-proxy

mkdir -p /etc/systemd/system/docker.service.d
vim /etc/systemd/system/docker.service.d/http-proxy.conf

# [Service]
# Environment="HTTP_PROXY=http://192.168.1.45:23333"
# Environment="HTTPS_PROXY=http://192.168.1.45:23333"
# Environment="NO_PROXY=localhost,127.0.0.1"

systemctl daemon-reload
systemctl show --property=Environment docker
systemctl start docker
