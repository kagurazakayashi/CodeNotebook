# CPU温度 （需 ÷ 1000）
cat /sys/class/thermal/thermal_zone0/temp # 物理CPU1
cat /sys/class/thermal/thermal_zone1/temp # 物理CPU2

# 最近一分钟，五分钟和十五分钟的系统负载
cat /proc/loadavg | cut -d ' ' -f 1-3

# CentOS
yum install lm_sensors -y
sensors-detect #一路YES
sensors

# Ubuntu
apt-get install lm-sensors -y
sensors-detect #一路YES
service kmod start
sensors