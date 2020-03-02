dnf install clamav clamav-* -y

# 升级我的病毒库
freshclam

# 扫描我计算机中的文件
clamscan

# 扫描指定路径
clamscan -r /location_of_files_or_folders

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

# ----------- SCAN SUMMARY -----------
# Known viruses: 6293114                    #病毒库中包含的病毒种类数
# Engine version: 0.99.2                         #引擎版本
# Scanned directories: 1                        #扫描目录数
# Scanned files: 24                                  #扫描文件数
# Infected files: 0                                      #被感染文件数
# Data scanned: 0.40 MB                       #总的扫描字节数
# Data read: 0.21 MB (ratio 1.87:1)       #数据读取
# Time: 7.917 sec (0 m 7 s)                   #花费的总时间

# 编译安装
# https://www.clamav.net/documents/installing-clamav-on-unix-linux-macos-from-source