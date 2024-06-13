# 修改文件描述符数量上限

# 临时增加文件描述符限制
ulimit -n 65535
# 查看
ulimit -n

# 永久增加文件描述符限制
# 1. 编辑 /etc/security/limits.conf 文件
vim /etc/security/limits.conf
# 增加以下内容：

# GPT & 阿里云推荐
# 增加普通用户的文件描述符限制
*               soft    nofile          65535
*               hard    nofile          65535
# 增加特定用户的文件描述符限制
root        soft    nofile          65535
root        hard    nofile          65535

# 或使用腾讯云推荐上述值
* soft nofile 100001
* hard nofile 100002
root soft nofile 100001
root hard nofile 100002


# 2. 修改以确保 PAM（Pluggable Authentication Modules）模块加载新的限制配置
vim /etc/pam.d/common-session
vim /etc/pam.d/common-session-noninteractive
# 在这两个文件中添加以下行
session required pam_limits.so

# 3. 如果需要增加系统级别的文件描述符限制
sysctl -w fs.file-max=2097152
vim /etc/sysctl.conf
# 添加以下行
fs.file-max=2097152

# 然后运行以下命令使配置生效
sysctl -p
# 重启。


# 修改 TCP 连接数上限

# 查看当前的最大连接数，当前系统的最大连接数限制
sysctl net.core.somaxconn
# 增加最大连接数 Arch&Debian12默认4096 GPT推荐1024 腾讯云推荐128
sysctl -w net.core.somaxconn=10000
vim /etc/sysctl.conf
# 添加以下行
net.core.somaxconn=10000

# 使用 netstat 或 ss 命令查看当前连接数
netstat -an | grep ESTABLISHED | wc -l
ss -s

# 检查 TCP 连接跟踪表（适用于高连接数场景）
# 查看当前连接跟踪表的使用情况
sysctl net.netfilter.nf_conntrack_count
# 查看连接跟踪表的最大限制
sysctl net.netfilter.nf_conntrack_max
# 增加连接跟踪表的最大限制 Arch&Debian12默认65536 GPT推荐131072 腾讯云推荐65536
sysctl -w net.netfilter.nf_conntrack_max=131072
vim /etc/sysctl.conf
# 添加以下行
net.netfilter.nf_conntrack_max=131072

# 系统日志中可能会记录连接数达到上限的错误信息
dmesg | grep -i conntrack
journalctl -k | grep -i conntrack
# 这些命令会显示与连接跟踪相关的内核日志信息。

# 检查进程级别的连接数
lsof -i -n -P | grep process_name | wc -l
netstat -anp | grep process_name | wc -l


# 阿里云推荐的其他参数
kernel.sysrq = 1
net.ipv4.neigh.default.gc_stale_time = 120
# see details in https://help.aliyun.com/knowledge_detail/39428.html
net.ipv4.conf.all.rp_filter = 0
net.ipv4.conf.default.rp_filter = 0
net.ipv4.conf.default.arp_announce = 2
net.ipv4.conf.lo.arp_announce = 2
net.ipv4.conf.all.arp_announce = 2
# see details in https://help.aliyun.com/knowledge_detail/41334.html
net.ipv4.tcp_max_tw_buckets = 5000
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_max_syn_backlog = 1024
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_slow_start_after_idle = 0

# 腾讯云推荐的其他参数
net.ipv4.ip_forward = 0
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.default.accept_source_route = 0
kernel.core_uses_pid = 1
net.ipv4.tcp_syncookies = 1
kernel.msgmnb = 65536
kernel.msgmax = 65536
net.ipv4.conf.all.promote_secondaries = 1
net.ipv4.conf.default.promote_secondaries = 1
net.ipv6.neigh.default.gc_thresh3 = 4096
net.ipv4.neigh.default.gc_thresh3 = 4096
kernel.softlockup_panic = 1
kernel.sysrq = 1
net.ipv6.conf.all.disable_ipv6 = 0
net.ipv6.conf.default.disable_ipv6 = 0
net.ipv6.conf.lo.disable_ipv6 = 0
kernel.numa_balancing = 0
kernel.shmmax = 68719476736
kernel.printk = 5
