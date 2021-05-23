yum install clamav "clamav-*" -y
# 或前往下载页 https://www.clamav.net/downloads
wget https://www.clamav.net/downloads/production/clamav-0.103.2.tar.gz
tar -zxvf clamav-0.103.2.tar.gz
cd clamav-0.103.2
./configure
# SELinux
setsebool -P antivirus_can_scan_system 1

# 升级我的病毒库
freshclam

# 扫描我计算机中的文件
clamscan -r /

# 扫描当前目录文件
clamscan

# 扫描指定路径
clamscan -r /location_of_files_or_folders

# 帮助
clamscan --help

# 默认扫描当前目录下的文件，并显示扫描结果统计信息
clamscan

# 扫描当前目录下的所有目录和文件，并显示结果统计信息
clamscan -r　

# 扫描data目录下的所有目录和文件，并显示结果统计信息
clamscan -r /data　 

# 扫描data目录下的所有目录和文件，只显示有问题的扫描结果
clamscan -r --bell -i /data  

# 扫描data目录下的所有目录和文件，不显示统计信息
clamscan --no-summary -ri /data

#删除扫描过程中的发现的病毒文件
/usr/local/clamav/bin/clamscan -r --remove

#扫描过程中发现病毒发出警报声
/usr/local/clamav/bin/clamscan -r --bell -i

#扫描并将发现的病毒文件移动至对应的路径下
/usr/local/clamav/bin/clamscan -r --move 路径

#扫描显示发现的病毒文件，一般文件后面会显示FOUND
/usr/local/clamav/bin/clamscan -r --infected -i

#扫描指定的单个文件
clamscan /bin/uame

#扫描当前目录下的所有文件
calmscan

#扫描/home目录下的所有文件和子目录
clamscan -r /home

#以/tmp/newclamdb文件或/tmp/newclamdb目录中的所有.cvd文件为病毒库，扫描/tmp目录下的所有文件和子目录
clamscan -d /tmp/newclamdb -r /tmp

#扫描一个数据流
cat testfile | clamscan -

#扫描邮箱目录，以查找包含病毒的邮件
clamscan -r /var/spool/mail

# 计划任务
# 00 00 * * * sudo clamscan -r /location_of_files_or_folders

rm -f /var/log/clamscan.log && freshclam && clamscan -i -l /var/log/clamscan.log --move=/vir -r /

# --quiet   使用安静模式，仅仅打印出错误信息
# -i  仅仅打印被感染的文件
# -d <文件> 以指定的文件作为病毒库，一代替默认的/var/clamav目录下的病毒库文件
# -l <文件> 指定日志文件，以代替默认的/var/log/clamav/freshclam.log文件
# -r 递归扫描，即扫描指定目录下的子目录
# --move=<目录> 把感染病毒的文件移动到指定目录
# --remove 删除感染病毒的文件

# ----------- SCAN SUMMARY -----------     #扫描摘要
# Known viruses: 6377069                   #已知病毒：6377069
# Engine version: 0.99.2                   #引擎版本：0.92.2
# Scanned directories: 18186               #扫描目录：18186
# Scanned files: 80762                     #扫描文件：80762
# Infected files: 46                       #感染档案：46
# Total errors: 4253                       #总误差：4253
# Data scanned: 4717.23 MB                 #数据扫描：4717.23兆字节
# Data read: 9475.00 MB (ratio 0.50:1)     #数据读取：9475MB（比0.50∶1）
# Time: 1939.667 sec (32 m 19 s)           #时间：1939.667秒（32分19秒）
# ---------------------

# 编译安装
# https://www.clamav.net/documents/installing-clamav-on-unix-linux-macos-from-source