yum install -y openssl-devel
# 下载源代码包 
wget https://mosquitto.org/files/source/mosquitto-1.6.9.tar.gz
# 解压
tar zxfv mosquitto-1.6.9.tar.gz
# 进入目录
cd mosquitto-1.6.9
# 预编译软件包
# cmake . -DCMAKE_INSTALL_BINDIR=/usr/bin \
#         -DCMAKE_INSTALL_SBINDIR=/usr/sbin \
#         -DCMAKE_INSTALL_LIBEXECDIR=/usr/libexec \
#         -DCMAKE_INSTALL_SYSCONFDIR=/etc \
#         -DCMAKE_INSTALL_LOCALSTATEDIR=/var \
#         -DCMAKE_INSTALL_LIBDIR=/usr/lib64 \
#         -DCMAKE_INSTALL_INCLUDEDIR=/usr/include \
#         -DCMAKE_INSTALL_DATAROOTDIR=/usr/share \
#         -DCMAKE_INSTALL_INFODIR=/usr/share/info \
#         -DCMAKE_INSTALL_LOCALEDIR=/usr/share/locale \
#         -DCMAKE_INSTALL_MANDIR=/usr/share/man \
#         -DCMAKE_INSTALL_DOCDIR=/usr/share/doc/mosquitto
# 编译
make
# 安装
sudo make install
which mosquitto
ln -s /usr/local/sbin/mosquitto /usr/sbin/mosquitto
# 创建运行用户
groupadd -g 309 mosquitto
useradd -u 309 -g 309 -d /var/lib/mosquitto/ -s /sbin/nologin mosquitto

# 创建服务
vim /usr/lib/systemd/system/mosquitto.service

[Unit]
Description=Eclipse Mosquitto manager
Wants=network.target
Before=network.target
After=network-pre.target
ConditionPathExists=/etc/mosquitto/mosquitto.conf
Documentation=man:mosquitto

[Service]
Type=forking
PIDFile=/var/run/mosquitto.pid
ExecStart=/usr/sbin/mosquitto -d -c /etc/mosquitto/mosquitto.conf
Restart=on-abort

[Install]
WantedBy=multi-user.target

# 创建服务2 (从Centos7直接拷贝)
[Unit]
Description=Mosquitto MQTT v3.1/v3.1.1 Broker
Documentation=man:mosquitto.conf(5) man:mosquitto(8)
After=network-online.target
Wants=network-online.target

[Service]
Type=notify
NotifyAccess=main
ExecStart=/usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf
ExecReload=/bin/kill -HUP $MAINPID
Restart=on-failure

[Install]
WantedBy=multi-user.target

# 配置文件
vim /etc/mosquitto/mosquitto.conf
# 登录需要密码
# 修改mosquitto.conf
# 关闭匿名模式
allow_anonymous false
# 指定密码文件
password_file /etc/mosquitto/pwfile.conf
# 设置日志路径
log_dest file /var/log/mosquitto.log #需要权限 可能导致无法启动
log_type all #error，warning，notice，all

# 创建配置文件中的文件
touch /etc/mosquitto/pwfile.conf
touch /var/log/mosquitto.log

# 对外开放端口
firewall-cmd --permanent --add-port=1883/tcp
firewall-cmd --reload

# 其他见 CentOS7安装MQTT协议服务器mosquitto.sh 文件

# 手动测试
mosquitto -c /etc/mosquitto/mosquitto.conf
#是否已在运行
netstat -antp | grep mosquitto
#结束
kill 2 `pgrep -u mosquitto mosquitto`

# 启动服务和服务控制
systemctl daemon-reload
systemctl start mosquitto.service
systemctl status mosquitto.service
systemctl stop mosquitto.service
systemctl restart mosquitto.service

# https://www.cmdschool.org/archives/6559