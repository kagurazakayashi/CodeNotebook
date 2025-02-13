# docker-acme免费证书 管理和删除
docker exec acme.sh --list
acme.sh --remove -d example.com
docker exec acme.sh --list
