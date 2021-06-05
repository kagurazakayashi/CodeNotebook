# 1. 停止旧的容器
docker stop portainer
# 2. 删除旧的容器
docker rm portainer
# 3. 删除旧的镜像
docker rmi portainer/portainer-ce
# 4. 拉取新的镜像
docker pull portainer/portainer-ce
# 5. 使用新的镜像启动新的容器
docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce