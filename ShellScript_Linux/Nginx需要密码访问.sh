yum install httpd-tools -y
htpasswd -c /mnt/data/存放密码的文件夹/密码存储文件 用户名

vim /usr/local/nginx/conf/vhost/网站.conf
# location ~ /网站需要加密的路径/* {
#     auth_basic "欢迎使用篝火客户系统，请输入您的密码：";
#     auth_basic_user_file /mnt/data/存放密码的文件夹/密码存储文件;
# }

# 在原有密码文件中增加下一个用户
htpasswd -b 密码存储文件 用户名 密码

# 删除
htpasswd -D 密码存储文件 用户名