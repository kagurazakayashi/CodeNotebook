dnf install epel-release -y
dnf install snapd -y
systemctl enable --now snapd.socket
ln -s /var/lib/snapd/snap /snap
# 重新登录
snap install mosquitto

vim /snap/mosquitto/269/default_config.conf

systemctl start snap.mosquitto.mosquitto.service
systemctl status snap.mosquitto.mosquitto.service
systemctl stop snap.mosquitto.mosquitto.service