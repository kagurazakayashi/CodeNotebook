chkconfig --list             #列出所有的系统服务。
chkconfig --add httpd        #增加httpd服务。
chkconfig --del httpd        #删除httpd服务。
chkconfig --level httpd 2345 on        #设置httpd在运行级别为2、3、4、5的情况下都是on（开启）的状态。
chkconfig --list               #列出系统所有的服务启动情况。
chkconfig --list mysqld        #列出mysqld服务设置情况。
chkconfig --level 35 mysqld on #设定mysqld在等级3和5为开机运行服务，--level 35表示操作只在等级3和5执行，on表示启动，off表示关闭。
chkconfig mysqld on            #设定mysqld在各等级为on，“各等级”包括2、3、4、5等级。


# 等级0表示：表示关机
# 等级1表示：单用户模式
# 等级2表示：无网络连接的多用户命令行模式
# 等级3表示：有网络连接的多用户命令行模式
# 等级4表示：不可用
# 等级5表示：带图形界面的多用户模式
# 等级6表示：重新启动

# https://man.linuxde.net/chkconfig