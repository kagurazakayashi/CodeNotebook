docker run --name postgre_sql -e POSTGRES_PASSWORD=mysecretpassword -d postgres


docker network create --subnet=172.18.0.0/16 work
docker volume create postgre_sql

# -p 5432:5432
docker run -it \
--net work --ip 172.18.0.4 \
--name postgre_sql \
-v postgre_sql:/var/lib/postgresql/data \
-e POSTGRES_PASSWORD=pahQuo3zeedisho2aghisoh0Enufaighoo7xoetaiNa6leeQuee8ijooQuoo9teipomo6Waenaihueph2teit5AeYaibieSoo5i \
-d postgres:latest

# 进入创建数据库用户名密码(最长密码99位)
docker exec -it postgre_sql psql -U postgres
CREATE USER mastodon WITH PASSWORD '数据库密码（最好和数据库管理员密码不一样）' CREATEDB;
\q
docker restart postgre_sql
