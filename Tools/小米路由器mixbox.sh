# mixbox

# 重载
source /etc/profile

# 备份文件
/etc/mbbackup.tar.gz
mv /etc/mbbackup.tar.gz /data/userdisk/mbbackup.tar.gz
mv /etc/mbbackup.tar.gz /extdisks/sda1/mbbackup.tar.gz
rm /data/userdisk/mbbackup.tar.gz
tar -zcvf /data/userdisk.tar.gz /data/userdisk
tar -zcvf /extdisks/sda1/userdisk.tar.gz /data/userdisk
mv /data/userdisk.tar.gz /data/userdisk/userdisk.tar.gz
rm /data/userdisk/userdisk.tar.gz

# SS配置
/data/userdisk/mixbox/apps/shadowsocks/config/

# DNS优化配置
/data/userdisk/mixbox/apps/smartdns/config/smartdns.conf

#共享文件夹
/data
/data/userdisk/share