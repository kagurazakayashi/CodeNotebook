# 安装docker compose, 官方文档：https://docs.docker.com/compose/install/
# 下载docker compose（Linux版本）
sudo curl -L "https://github.com/docker/compose/releases/download/2.20.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# 增加执行权限
sudo chmod +x /usr/local/bin/docker-compose
# 成功检查
docker-compose -v

# 1、准备好需要修改的配置文件（比如nginx.conf等），如果需要自己构建Dockerfile文件，也请准备好Dockerfile
# 2、在 docker-compose.yml 中定义好各个容器的相关配置
# 3、执行docker-compose up -d命令，docker compose会帮你完成一整套拉取镜像/构建镜像，启动容器等操作。
# docker-compose.yml是docker compose用来配置容器应用的配置文件，默认就叫docker-compose.yml，最好是放在当前操作的目录下，当然也可以单独指定文件路径。

# docker compose的常用命令
#启动并后台运行所有的服务 
docker-compose up  -d 
#列出项目中目前的所有容器 
docker-compose ps 
#停止某个服务 
docker-compose stop 服务名 
#启动某个服务 
docker-compose start 服务名 
#停止并删除容器、网络、卷、镜像 
docker-compose down

