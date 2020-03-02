# CentOS
yum install lm_sensors -y
sensors-detect #一路YES
sensors

# Ubuntu
apt-get install lm-sensors -y
sensors-detect #一路YES
service kmod start
sensors