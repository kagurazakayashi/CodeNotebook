#!/bin/bash
# SSH执行远程命令
ssh -i "SSH证书文件.pem" "$远程用户@$远程主机" << EOF
docker stop nginx
docker start nginx
EOF
