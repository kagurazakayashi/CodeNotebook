# 1、检查Firewalld是否启用
#如果您已经安装iptables建议先关闭
service iptables stop
#查看Firewalld状态
firewall-cmd --state
#启动firewalld
systemctl start firewalld
#设置开机启动
systemctl enable firewalld.service
# 启用Firewalld后会禁止所有端口连接，因此请务必放行常用的端口，以免被阻挡在外，以下是放行SSH端口（22）示例，供参考：
#放行22端口
firewall-cmd --zone=public --add-port=22/tcp --permanent
#重载配置
firewall-cmd --reload
#查看已放行端口
firewall-cmd --zone=public --list-ports

# 2、安装fail2ban
# fail2ban可以监控系统日志，并且根据一定规则匹配异常IP后使用Firewalld将其屏蔽，尤其是针对一些爆破/扫描等非常有效。
#CentOS内置源并未包含fail2ban，需要先安装epel源
yum -y install epel-release
#安装fial2ban
yum -y install fail2ban
# 安装成功后fail2ban配置文件位于/etc/fail2ban，其中jail.conf为主配置文件，相关的匹配规则位于filter.d目录，其它目录/文件一般很少用到，如果需要详细了解可自行搜索。

# 3、配置规则
# 新建jail.local来覆盖fail2ban的一些默认规则：
#新建配置
vim /etc/fail2ban/jail.conf
#默认配置
[DEFAULT]
ignoreip = 127.0.0.1/8 #忽略的IP列表（白名单）
bantime  = 86400 #屏蔽时间，秒
findtime = 600 #这个时间段超过规定次数就会被ban掉
maxretry = 5 #最大尝试次数
#这里banaction必须用firewallcmd-ipset,这是fiewalll支持的关键，如果是用Iptables请不要这样填写
banaction = firewallcmd-ipset
action = %(action_mwl)s

# 参数说明：
# ignoreip：IP白名单，白名单中的IP不会屏蔽，可填写多个以（,）分隔
# bantime：屏蔽时间，单位为秒（s）
# findtime：时间范围
# maxretry：最大次数
# banaction：屏蔽IP所使用的方法，上面使用firewalld屏蔽端口

## 防止SSH爆破
vim /etc/fail2ban/jail.conf
# 继续修改jail.local这个配置文件，在后面追加如下内容：
[sshd]
enabled = true
filter  = sshd
port    = 22
action = %(action_mwl)s
logpath = /var/log/secure

# 参数说明：
# [sshd]：名称，可以随便填写
# filter：规则名称，必须填写位于filter.d目录里面的规则，sshd是fail2ban内置规则
# port：对应的端口
# action：采取的行动
# logpath：需要监视的日志路径

# 查看被ban的IP
fail2ban-client status sshd

## 防止CC攻击
# 这里仅以Nginx为例，使用fail2ban来监视nginx日志，匹配短时间内频繁请求的IP，并使用firewalld将其IP屏蔽，达到CC防护的作用。

#需要先新建一个nginx日志匹配规则
vi /etc/fail2ban/filter.d/nginx-cc.conf
#填写如下内容
[Definition]
failregex =  -.*- .*HTTP/1.* .* .*$
ignoreregex =

# 继续修改jail.local追加如下内容：
vim /etc/fail2ban/jail.conf
[nginx-cc]
enabled = true
port = http,https
filter = nginx-cc
action = %(action_mwl)s
maxretry = 20
findtime = 60
bantime = 3600
logpath = /usr/local/nginx/logs/access.log
# 上面的配置意思是如果在60s内，同一IP达到20次请求，则将其IP ban 1小时，上面只是为了测试，请根据自己的实际情况修改。logpath为nginx日志路径。

## 防止Wordpress爆破
# 如果您经常分析日志会发现有大量机器人在扫描wordpress登录页面wp-login.php，虽然对方可能没成功，但是为了避免万一还是将他IP干掉为好。
#需要先新建一个nginx日志匹配规则
vi /etc/fail2ban/filter.d/wordpress.conf
#填写如下内容
# [Definition]
# failregex = ^ -.* /wp-login.php.* HTTP/1\.."
# ignoreregex =

# 继续修改jail.local追加如下内容：
[wordpress]
enabled = true
port = http,https
filter = wordpress
action = %(action_mwl)s
maxretry = 20
findtime = 60
bantime = 3600
logpath = /usr/local/nginx/logs/access.log

## 常用命令
#启动
systemctl start fail2ban
#停止
systemctl stop fail2ban
#开机启动
systemctl enable fail2ban
#查看被ban IP，其中sshd为名称，比如上面的[wordpress]
fail2ban-client status sshd
#删除被ban IP
fail2ban-client set sshd delignoreip 192.168.111.111
#查看日志
tail /var/log/fail2ban.log

# https://www.centos.bz/2018/01/centos-7%E5%AE%89%E8%A3%85fail2banfirewalld%E9%98%B2%E6%AD%A2ssh%E7%88%86%E7%A0%B4%E4%B8%8Ecc%E6%94%BB%E5%87%BB/