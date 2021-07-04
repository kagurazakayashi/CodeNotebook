# 方法1
firewall-cmd --permanent --zone=trusted --change-interface=docker0
firewall-cmd --reload

# 方法2
nmcli connection modify docker0 connection.zone trusted
systemctl stop NetworkManager.service
firewall-cmd --permanent --zone=trusted --change-interface=docker0
systemctl start NetworkManager.service
nmcli connection modify docker0 connection.zone trusted
systemctl restart docker.service

# 方法3
# Masquerading allows for docker ingress and egress (this is the juicy bit)
firewall-cmd --zone=public --add-masquerade --permanent
# Specifically allow incoming traffic on port 80/443 (nothing new here)
firewall-cmd --zone=public --add-port=80/tcp
firewall-cmd --zone=public --add-port=443/tcp
# Reload firewall to apply permanent rules
firewall-cmd --reload