# 附加配置

安装管理包（浏览器管理界面）
`yum install -y tomcat-webapps tomcat-admin-webapps`

安装在线文档（可选）
`yum install -y tomcat-docs-webapp tomcat-javadoc`

防火墙通行
`firewall-cmd --zone=public --add-port=8080/tcp --permanent`
`systemctl restart firewalld.service`

开机启动
`systemctl enable tomcat.service`

重启服务
`systemctl restart tomcat`

# 安装位置
/etc/tomcat

## 主程序/软件存放webapp位置
/var/lib/tomcat/webapps

## 在Centos使用yum安装后，Tomcat相关的目录都已采用符号链接到/usr/share/tomcat6目录，包含webapps等，这很方便我们配置管理
/usr/share/tomcat

## 日志记录位置
/var/log/tomcat

## 要查看所有tomcat分散请求下面目录查看
/usr/share/tomcat

## 查看全部tomcat安装目录
rpm -ql tomcat | cat -n


# choco 安装
C:\ProgramData\Tomcat9

# yum 安装
/usr/share/tomcat/