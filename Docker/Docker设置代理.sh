systemctl stop docker
mkdir -p /etc/systemd/system/docker.service.d
vim /etc/systemd/system/docker.service.d/http-proxy.conf
# [Service]
# Environment="HTTP_PROXY=http://127.0.0.1:1081/"
systemctl daemon-reload
systemctl show --property=Environment docker
systemctl start docker