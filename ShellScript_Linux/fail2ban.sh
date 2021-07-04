# 服务器基础防护设置：
# 1.密码满足复杂性要求。
# 2.修改ssh程序默认的远程端口。
# 3.修改默认管理员账号：新建一个超级管理员账号，并把root改称为nologin。

# Fail2ban的源码安装：
# 一、下载源码包：
wget https://codeload.github.com/fail2ban/fail2ban/tar.gz/0.8.14
# 二、解压源码包：
tar -xvf 0.8.14
# 三、安装：
cd fail2ban-0.8.14
python setup.py install
# 四、生成启动脚本：
cp files/redhat-initd /etc/init.d/fail2ban
chkconfig --add fail2ban

# Fail2ban的配置文件：
/etc/fail2ban/action.d #动作文件夹，内含默认文件。iptables及mail等动作配置。
/etc/fail2ban/fail2ban.conf #定义了fail2ban日志级别、日志位置及sock文件位置。
/etc/fail2ban/filter.d #条件文件夹，内含默认文件。过滤日志关键内容设置。
/etc/fail2ban/jail.conf #主要配置文件，模块化。主要设置启动ban动作的服务及动作阈值。

# 启动和检查Fail2ban:
service fail2ban restart
fail2ban-client status

# 查看效果：
iptables -L |tail -4 ##查看禁止的IP
# 查看日志
vi /var/lo/fail2ban.log

# 案例一：ssh远程登录5分钟内3次密码验证失败，禁止用户IP访问主机1小时，1小时后限制自动解除。
vim /etc/fail2ban/jail.conf

[DEFAULT]
ignoreip=127.0.0.1/8 ##忽略的IP列表（白名单）
bantime=3600 ##屏蔽时间，秒
findtime=300 ##这个时间段超过规定次数就会被ban掉
maxretry=3 ##最大尝试次数
backend=auto ##日志修改检测机制（gamin、polling和auto三种）
[ssh-iptables] ##针对各种服务的检查配置，如设置bantime、findtime、maxretry和全局冲突，服务优先级大于全局
enabled=true ##是否激活此服务
filter=sshd ##过滤规则filter的名字，对应filter.d目录下的sshd.conf
action=iptables[name=SSH,port=sh,protocol=tcp] ##动作的相关参数
sendmail-whois[name=SSH,dest=xx@example.com,sender=fail2ban@example.com,sendername="Fail2ban"] ##邮件告警配置
logpath=/var/log/secure ##检测的系统的登陆日志文件
maxretry=3 ##最大尝试次数

# 案例二：Nginx防护（规定时间内超过限定访问次数的IP封锁）
vim /etc/fail2ban/jail.conf

[nginx]
enabled=true
filter=nginx
action=iptables[name=nginx,port=http,protocol=tcp]
sendmail-whois[name=nginx,dest=xx@example.com,sender=fail2ban@example.com,sendername="Fail2ban"]
logpath=/var/log/httpd/access_log ##检测Nginx访问日志
bantime=86400
findtime=600
maxretry=1000
[Definition]
failregex = .-.-.*$ ##表示访问IP，最简单的正则匹配。没有精确到精确地URL。
ignoreregex=

#测试条件规则是否可用
fail2ban-regex /var/log/httpd/access_log /etc/fail2ban/filter.d/nginx.conf
fail2ban-client status
#可以看到两个实例在监控
# Status|- Number of jail: 2 
# `- Jail list: nginx, ssh-iptables

# 查看被Ban掉的IP
fail2ban-client status nginx
# Status for the jail: nginx|- filter| |- File list: /var/log/httpd/access_log| |- Currently failed: 1 
# | - Total failed: 39 
# - action|- Currently banned: 1 
# | - IP list: 192.168.214.1 
# - Total banned: 1

# https://yq.aliyun.com/articles/195078
# https://blog.csdn.net/rjx040566/article/details/81513809