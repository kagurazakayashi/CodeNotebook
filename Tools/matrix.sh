# https://hub.docker.com/r/matrixdotorg/synapse

docker network create --subnet=172.20.0.0/16 matrix

# 生成配置文件 到 /mnt/d/matrix/data
docker run -it --rm \
    -v /mnt/d/matrix/data:/data \
    -e SYNAPSE_SERVER_NAME=域名 \
    -e SYNAPSE_REPORT_STATS=yes \
    -e TZ=Asia/Shanghai \
    matrixdotorg/synapse:latest generate


# 初始化PostgreSQL(最长密码99位)
docker run --name matrix_db -v /mnt/d/matrix/postgres:/var/lib/postgresql/data --net matrix --ip 172.20.0.3 -e POSTGRES_PASSWORD=数据库密码 -d postgres:latest
# 进入docker db容器：
docker exec -it matrix_db /bin/bash
su - postgres
createuser --pwprompt matrix
createdb --encoding=UTF8 --locale=C --template=template0 --owner=matrix matrix
exit
exit

# 修改生成的 /mnt/d/matrix/data/homeserver.yaml
# 一旦你有了一个有效的配置文件，你就可以按如下方式启动 synapse：

docker run -d --name matrix_synapse -v /mnt/d/matrix/data:/data --net matrix --ip 172.20.0.2 -p 8008:8008 matrixdotorg/synapse:latest

# 生成（管理员）用户
docker exec -it matrix_synapse register_new_matrix_user http://172.20.0.2:8008 -c /data/homeserver.yaml --help
docker exec -it matrix_synapse register_new_matrix_user http://172.20.0.2:8008 -c /data/homeserver.yaml -u 管理员账户名 -p 管理员账户密码 -a
# 这需要 registration_shared_secret 您的配置文件中。如果不再需要它，请记住删除并重新启动。

# 更新
docker stop matrix_synapse
docker stop matrix_db
docker rm matrix_synapse
docker rmi matrixdotorg/synapse:latest
docker start matrix_db
docker run -d --name matrix_synapse -v /mnt/d/matrix/data:/data --net matrix --ip 172.20.0.2 -p 8448:8008 matrixdotorg/synapse:latest

# nginx 反代

location ~ ^(/_matrix|/_synapse/client) {
    proxy_pass http://172.20.0.2:8008;
    proxy_set_header X-Forwarded-For $remote_addr;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header Host $host;
    client_max_body_size 50M;
}

# synapse-admin

https://github.com/Awesome-Technologies/synapse-admin
https://awesome-technologies.github.io/synapse-admin
