# CentOS8 添加wlnmp源
rpm -ivh http://mirrors.wlnmp.com/centos/wlnmp-release-centos.noarch.rpm

# 安装ntp服务
yum install wntp

# 时间同步
ntpdate ntp1.aliyun.com

# 只查询目标服务器时间
ntpdate -q ntp1.aliyun.com

# 更新本服务器的时间
ntpdate -u ntp.ntsc.ac.cn

# 设置时区
timedatectl set-timezone 'Asia/Shanghai'

# 启动和停止客户端服务
/bin/systemctl restart ntpd.service

# 设置服务器配置文件
cp /etc/ntp.conf /etc/ntp.conf.bak
vim /etc/ntp.conf

# 启动 NTP 服务器
/etc/init.d/ntpd start

# 查看 NTP 服务是否开机启动
chkconfig --list ntpd

# 设置为开机启动
chkconfig --level 2345 ntpd on

# 通过ntpq –p静态查看NTP服务器与外部NTP服务器同步情况。
ntpq –p
# 动态查看NTP服务器与外部NTP服务器同步情况,一般需要等5--10分钟左右NTP服务器才会与外部NTP服务器同步。
watch ntpq -p
# st：即stratum阶层，值越小表示ntp serve的精准度越高。
# when：几秒前曾做过时间同步更新的操作。
# Poll表示，每隔多少毫秒与ntp server同步一次。
# reach：已经向上层NTP服务器要求更新的次数。
# delay：网络传输过程钟延迟的时间。
# offset：时间补偿的结果。
# jitter：Linux系统时间与BIOS硬件时间的差异时间。

# 将同步好的系统时间写入到硬件(BIOS)时间里。
vim /etc/stsconfig/ntpd
# 只需要添加 SYNC_HWCLOCK=yes

# https://www.cnblogs.com/zoulongbin/p/6198186.html