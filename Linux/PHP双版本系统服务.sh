#/lib/systemd/system/

vi /lib/systemd/system/yashi-nginx.service
# [Unit]
# Description=yashi-nginx
# After=network.target
# [Service]
# Type=forking
# ExecStart=/usr/local/nginx -c /usr/local/nginx/conf/nginx.conf
# ExecReload=/usr/local/nginx -s reload
# ExecStop=/usr/local/nginx -s quit
# PrivateTmp=true
# [Install]
# WantedBy=multi-user.target

# vi /lib/systemd/system/yashi-php7.service
# [Unit]
# Description=yashi-php7
# After=network.target
# [Service]
# Type=forking
# ExecStart=/usr/local/php/sbin/php-fpm
# PrivateTmp=true
# [Install]
# WantedBy=multi-user.target

# vi /lib/systemd/system/yashi-php5.service
# [Unit]
# Description=yashi-php5
# After=network.target
# [Service]
# Type=forking
# ExecStart=/usr/local/php56/sbin/php-fpm
# PrivateTmp=true
# [Install]
# WantedBy=multi-user.target

systemctl enable yashi-nginx.service
systemctl enable yashi-php.service
systemctl enable yashi-php5.service

# 自带：
systemctl enable php-fpm
systemctl enable php-fpm56
systemctl enable nginx
systemctl enable mysql
systemctl enable pureftpd
