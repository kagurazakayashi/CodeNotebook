# 安装和启动服务
yum -y install epel-release
yum -y install mosquitto
systemctl start mosquitto
systemctl enable mosquitto

# 订阅 test 主题
mosquitto_sub -h localhost -t test
# 发布内容到 test 主题
mosquitto_pub -h localhost -t test -m "hello world"

# 配置MQTT密码（保存到密码文件 /etc/mosquitto/passwd ）
# 注意：会直接覆盖密码文件
mosquitto_passwd -c /etc/mosquitto/passwd <用户名>

# 修改配置
vim /etc/mosquitto/mosquitto.conf
# 取消禁止所有人登录
allow_anonymous false
# 设置密码文件路径
password_file /etc/mosquitto/passwd

# 重新启动Mosquitto
systemctl restart mosquitto

# 带密码订阅主题
mosquitto_sub -h localhost -t test -u "sammy" -P "password"
# 带密码发送主题
mosquitto_pub -h localhost -t "test" -m "hello world" -u "sammy" -P "password"

# 配置SSL加密
vim /etc/mosquitto/mosquitto.conf

listener 1883 # 默认端口
listener 8883 # 加密端口
certfile /etc/Tencent_Cloud_SSL/live/mqtt.example.com/cert.pem
cafile /etc/Tencent_Cloud_SSL/live/mqtt.example.com/chain.pem
keyfile /etc/Tencent_Cloud_SSL/live/mqtt.example.com/privkey.pem

# 以 root 用户初始服务
vim /etc/systemd/system/multi-user.target.wants/mosquitto.service
# User=mosquitto
# 无需写此行以拥有 root 来加载 SSl证书，在装载证书后，它将自动变为到mosquitto的用户。
systemctl daemon-reload
systemctl restart mosquitto
systemctl status mosquitto

# 对外开放端口
firewall-cmd --permanent --add-port=8883/tcp
firewall-cmd --reload

# 带证书带密码订阅
mosquitto_pub -h mqtt.example.com -t test -m "hello again" -p 8883 --cafile /etc/ssl/certs/ca-bundle.crt -u "sammy" -P "password"

# 其他
# https://cloud.tencent.com/developer/article/1180072