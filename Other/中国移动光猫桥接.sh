# 配置连接：静态
# IP = 192.168.1.xxx
# 子网掩码 = 255.255.255.0
# 网关 = 192.168.1.1

# MAC 地址示例： D0-78-80-DB-79-09

# 启用 HG6145F telnet ，key 就是不带 - 的全大写 MAC
curl "http://192.168.1.1/cgi-bin/telnetenable.cgi?telnetenable=1&key=D07880DB7909"
# 输出：telnet开启

# 连接 telnet
telnet 192.168.1.1
# 用户名 admin
# 密码 Fh@DB7909   # Fh@ + MAC 后 6 位不带 - 的全大写 MAC
# 输出 #_

# 进入工厂模式
load_cli factory
# Config\factorydir#_

# 管理员用户名
show admin_name
# Success! admin_name=CMCCAdmin

# 管理员密码
show admin_pwd
# Success! admin_pwd=aDm8H%MdA

# 退出工厂模式
exit

# 访问 192.168.1.1 输入用户名密码。

# 修改 2_INTERNET_B_VID_10 连接模式为 桥接 ，
# LAN端口绑定设置一个或多个对应的端口（可留不绑定的来以后操作控制台）。

# 删除 1_TR069_R_VID_4003 防止被运营商远程控制恢复更改

# 1_TR069_R_VID_4003 不让删的话，继续 telnet 操作：

# 找配置文件集
find / -name "*.conf"
# 得到网页用选项对应的路径
cat /var/InternetGatewayDevice/WANDevice/1/WANConnectionDevice/1/WANIPConnection/value.conf
# 也就是说 WANConnectionDevice:1 就是 1_TR069_R_VID_4003 这个配置，但是直接删重启会还原

# 显示管理员用户名密码的另一个命令，直接读取了设置，路径格式是类似的，变成了 .
cfg_cmd showvalue InternetGatewayDevice.DeviceInfo.X_CMCC_TeleComAccount. 1
# 以此类推，把上面的路径转换为 . 读取
cfg_cmd showvalue InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection. 1
# 把 showvalue 改成 del 删除
cfg_cmd del InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection. 1
# 重启，刷新网页确认已删除
reboot
