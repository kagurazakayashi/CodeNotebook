# https://hub.docker.com/r/matrixdotorg/synapse

docker network create --subnet=172.20.0.0/16 matrix

# 生成配置文件 到 /mnt/d/matrix/data
docker run -it --rm \
    -v /mnt/d/matrix/data:/data \
    -e SYNAPSE_SERVER_NAME=x.uuu.moe \
    -e SYNAPSE_REPORT_STATS=yes \
    -e TZ=Asia/Shanghai \
    matrixdotorg/synapse:latest generate


# 初始化PostgreSQL(最长密码99位)
docker run --name matrix_db -v /mnt/d/matrix/postgres:/var/lib/postgresql/data --net matrix --ip 172.20.0.3 -e POSTGRES_PASSWORD=xaiZahGeePohkoh9aeyi1hofe7CieThohvahngo7ahzahDeiza3zoongitei7aR1zaimooshu7doo2fo1fahxu9chohciphe6oa -d postgres:latest
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
docker exec -it matrix_synapse register_new_matrix_user http://172.20.0.2:8008 -c /data/homeserver.yaml -u yashi -p ieTaW9johm7ureiPhae3Cahjoipheilaeg9thooxaishiet2wieg7vaic8ejahphek6gahxaedewei9daishooKia5eiY7moh4a -a
# 这需要 registration_shared_secret 您的配置文件中。如果不再需要它，请记住删除并重新启动。

# nginx 反代

location ~ ^(/_matrix|/_synapse/client) {
    proxy_pass http://localhost:8008;
    proxy_set_header X-Forwarded-For $remote_addr;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header Host $host;
    client_max_body_size 50M;
}

# synapse-admin

https://github.com/Awesome-Technologies/synapse-admin
https://awesome-technologies.github.io/synapse-admin
