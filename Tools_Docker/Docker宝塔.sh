mkdir /usr/local/var/www  # macOS
docker volume create btwww
# 桌面控制面板 - 设置 - Resources - FILE SHARING - 
# 添加 /usr/local/var/www
docker run --name bt -d -it -p 8888:8888 -p 80:80 -p 443:443 -p 20:20 -p 21:21 -p 21100-21110:21100-21110 -p 3306:3306 -p 6379:6379 -v btwww:/www -v /usr/local/var/www:/www/wwwroot debian:latest
docker exec -ti -u root bt /bin/bash
# 安装宝塔

# 只有网页+PHP
docker run --name bt -d -it -p 8888:8888 -p 80:80 -p 443:443 -v btwww:/www -v /usr/local/var/www:/www/wwwroot debian:latest