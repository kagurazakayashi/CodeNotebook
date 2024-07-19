# 1. 停止旧的容器
docker stop portainer
# 2. 删除旧的容器
docker rm portainer
# 3. 删除旧的镜像
docker rmi portainer/portainer-ce
docker rmi portainer/portainer-ce:2.16.2
# 4. 拉取新的镜像
docker pull portainer/portainer-ce
# 5. 使用新的镜像启动新的容器
docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

# client version 1.41 is too new 则用旧版本
docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:2.16.2

# NAS
sudo docker stop PortainerCE && sudo docker rm PortainerCE
sudo docker rmi portainer/portainer-ce
sudo docker run -d --name PortainerCE -p 19800:8000 -p 19900:9000 -p 19943:9443 --restart unless-stopped -v /var/run/docker.sock:/var/run/docker.sock -v /usr/builtin/etc/certificate:/certs -v /share/Docker/PortainerCE/data:/data -v /etc/localtime:/etc/localtime -e PATH:"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
" portainer/portainer-ce --sslcert /certs/ssl.pem --sslkey /certs/ssl.pem

# 离线更新
docker stop portainer
# 导出镜像（普通/压缩）
docker image save portainer/portainer-ce -o portainer.tar
docker image save portainer/portainer-ce | xz -z -9 -e -T 0 -v >portainer.tar.xz
# 导入镜像（普通/压缩）
docker image load -i portainer.tar
xz -d portainer.tar.xz -c | docker image load

docker start portainer
rm portainer.tar
