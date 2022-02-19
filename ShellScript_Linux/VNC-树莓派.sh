# 替换树莓派自带禁止商用的VNC服务器
sudo apt install tightvncserver -y
# 安装好之后请一定先使用此命令设置一个VNC密码（先输入操作密码两次，然后会询问是否设置一个查看(view-only)密码，按自己喜欢，一般没必要。）
vncpasswd
# 设置开机启动，需要在/etc/init.d/中创建一个文件。例如tightvncserver：（注：启动脚本的名称，有和程序名一致的习惯）
sudo vi /etc/init.d/tightvncserver
# 内容如下：
# ****************************************

#!/bin/sh
### BEGIN INIT INFO
# Provides:          tightvncserver
# Required-Start:    $local_fs
# Required-Stop:     $local_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start/stop tightvncserver
### END INIT INFO

# More details see:
# http://www.penguintutor.com/linux/tightvnc

### Customize this entry
# Set the USER variable to the name of the user to start tightvncserver under
# USER变量的值为默认用户名，这里是pi
export USER='pi'
### End customization required

eval cd ~$USER

case "$1" in
  start)
    # 启动命令行。此处自定义分辨率、控制台号码或其它参数。
    su $USER -c '/usr/bin/tightvncserver -depth 16 -geometry 1280x720 :1'
    echo "Starting TightVNC server for $USER "
    ;;
  stop)
    # 终止命令行。此处控制台号码与启动一致。
    su $USER -c '/usr/bin/tightvncserver -kill :1'
    echo "Tightvncserver stopped"
    ;;
  *)
    echo "Usage: /etc/init.d/tightvncserver {start|stop}"
    exit 1
    ;;
esac
exit 0

# ****************************************

# 然后给 tightvncserver 文件加执行权限：
sudo chmod 755 /etc/init.d/tightvncserver
# 并更新开机启动列表：
sudo update-rc.d tightvncserver defaults
# 防火墙允许：
sudo ufw allow 5901/tcp
# 重启树莓派：
sudo shutdown -r now



# 手动启动
# 当然也可以手动启动VNC服务器程序，使用以下命令：
tightvncserver -geometry 1280x720 :1
# -geometry 分辨率。可以不加。

# 终止VNC控制台：
tightvncserver -kill :1



# 连接
127.0.0.1:1
127.0.0.1:5901