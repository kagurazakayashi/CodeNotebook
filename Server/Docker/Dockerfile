# 每一个指令都会在镜像上创建一个新的层，每一个指令的前缀都必须是大写的。

# FROM，指定使用哪个镜像源
FROM    centos:6.7
MAINTAINER      Fisher "fisher@sudops.com"
# RUN 指令告诉docker 在镜像内执行命令，安装了什么
RUN     /bin/echo 'root:123456' |chpasswd
RUN     useradd runoob
RUN     /bin/echo 'runoob:123456' |chpasswd
RUN     /bin/echo -e "LANG=\"en_US.UTF-8\"" >/etc/default/local
EXPOSE  22
EXPOSE  80
CMD     /usr/sbin/sshd -D
# 然后，我们使用 Dockerfile 文件，通过 docker build 命令来构建一个镜像。
# docker build -t runoob/centos:6.7 .
# -t ：指定要创建的目标镜像名
# . ：Dockerfile 文件所在目录，可以指定Dockerfile 的绝对路径