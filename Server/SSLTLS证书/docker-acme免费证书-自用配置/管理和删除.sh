# docker-acme免费证书-自用配置-管理和删除
docker exec acme.sh --list
acme.sh --remove -d example.com
docker exec acme.sh --list
