# 只查询
## Linux
ntpdate -q ntp.aliyun.com
## Windows
w32tm /stripchart /samples:1 /dataonly /computer:ntp.aliyun.com

# 手动同步一次时间
## Linux
ntpdate ntp.aliyun.com
## Windows
w32tm /config /manualpeerlist:"time.windows.com" /syncfromflags:manual /reliable:YES /update
w32tm /resync

# 自动从指定服务器同步时间
vi /etc/ntp.conf
#+ server ntp.aliyun.com iburst
#或 server ntp.aliyun.com iburst minpoll 4 maxpoll 10

# 若您的发行版使用 Chrony
vi /etc/chrony.conf
#+ server ntp.aliyun.com iburst

# 检查NTP服务
systemctl status ntpd
# 启动自定义的NTP服务
service ntpd start
# 设置开机自启动NTP服务
chkconfig ntpd on
# 查看是否启动了NTP服务
ntpstat

# 查看当前时间
date
# 查看当前时区
date -R

# https://help.aliyun.com/document_detail/92803.htm?spm=a2c4g.11186623.2.6.6ab422d57Xiy9P#TimeCalibrationLinux