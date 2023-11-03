# DockerPHP安装扩展

# PHP中安装拓展有几个特殊的命令
docker-php-source
docker-php-ext-install
docker-php-ext-enable
docker-php-ext-configure

# 安装mysqli扩展
docker exec -it php /bin/bash
docker-php-ext-install mysqli
docker restart php
