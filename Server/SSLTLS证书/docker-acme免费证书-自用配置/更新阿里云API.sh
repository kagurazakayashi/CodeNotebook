#!/bin/bash
# docker-acme免费证书-自用配置-阿里云API更新（已不需要）
rm -f "./aliyun"
curl -o "aliyun-cli-linux-latest-amd64.tgz" "https://aliyuncli.alicdn.com/aliyun-cli-linux-latest-amd64.tgz"
tar xzvf "aliyun-cli-linux-latest-amd64.tgz"
rm -f "aliyun-cli-linux-latest-amd64.tgz"
mv "./aliyun" "/var/lib/docker/volumes/ssl_acme/_data/aliyun"
chmod +x "/var/lib/docker/volumes/ssl_acme/_data/aliyun"
