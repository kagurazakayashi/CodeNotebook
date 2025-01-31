#!/bin/bash
# 执行远程服务器Docker容器中的命令
Docker容器名称="nginx"
echo "重载 Docker 容器: $Docker容器名称 于 $远程主机..."

ssh -i "SSH证书文件.pem" "$远程用户@$远程主机" << EOF
# 重启
docker restart $Docker容器名称
# 执行命令
docker exec $Docker容器名称 nginx -t
docker exec $Docker容器名称 nginx -s reload
EOF

if [ $? -eq 0 ]; then
    echo "$远程主机 上的 Docker 容器 '$Docker容器名称' 已成功重载。"
else
    echo "$远程主机 上的 Docker 容器 '$Docker容器名称' 重载失败。"
fi
