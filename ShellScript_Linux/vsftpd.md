# FTP服务

## /etc/vsftpd/vsftpd.conf
存储 vsftpd 服务的配置信息

## /etc/vsftpd.ftpusers
指出不可以通过 FTP 登录的用户

## /etc/vsftpd.user_list

# 主目录

- 匿名用户： `/var/ftp`
- 用户的主目录是系统的主目录

# 使用 FTP 命令连接 FTP 服务器

- FTP 的子命令：
  - `open`,`quit`,`help`,`ls`,`get`,`put`.