# 添加用户
adduser mastodon
# 移动原来用户中的文件 /home/mastodon/mastodon

# 拉取镜像
docker pull tootsuite/mastodon:latest

# 编辑 docker-compose.yml
# 如果没有
wget https://raw.githubusercontent.com/tootsuite/mastodon/master/docker-compose.yml
# 编辑 docker-compose.yml
vim docker-compose.yml
# 修改数据库版本 image: postgres:12.5-alpine （可选）
# 依次找到web、streaming、sidekiq分类，在每一类的image: tootsuite/mastodon后添加:latest或者你刚才拉取的版本号，变成image: tootsuite/mastodon:latest或image: tootsuite/mastodon:v3.2.1等等。

# 初始化PostgreSQL(最长密码99位)
docker run --name mastodon_db_1 -v /home/mastodon/mastodon/postgres:/var/lib/postgresql/data -e POSTGRES_PASSWORD=设置数据库管理员密码 -d postgres:latest

# 进入创建数据库用户名密码(最长密码99位)
docker exec -it mastodon_db_1 psql -U postgres
CREATE USER mastodon WITH PASSWORD '数据库密码（最好和数据库管理员密码不一样）' CREATEDB;
\q
docker stop mastodon_db_1

# 复制并修改旧配置文件 /home/mastodon/mastodon/.env.production
vim .env.production
# DB_HOST=db
# REDIS_HOST=redis
# ES_HOST=es

# 此时，用ls -a命令查看/home/mastodon/mastodon文件夹，应该仅能看到你刚刚改好的.env.production，和你已经按照之前的安装教程改好的docker-compose.yml两个文件。

# 备份数据库
# 进入原来的数据库用户，如果是 docker：
docker exec -it mastodon_db_1 /bin/bash
su - postgres
cd /var/lib/postgresql/data
pg_dump -Fc mastodon -f mastodon.dump
exit
exit
cd /home/mastodon/mastodon/postgres
xz -1 -v -T 0 mastodon.dump
# 新服：
# 设置数据库用户名密码 DB_NAME，DB_USER，DB_PASS
vim /home/mastodon/mastodon/.env.production
# 进入docker db容器：
docker exec -it mastodon_db_1 /bin/bash
su - postgres
createdb -T template0 mastodon # 建立新的空白数据库
psql
CREATE USER mastodon WITH PASSWORD '数据库密码';
GRANT ALL PRIVILEGES ON DATABASE mastodon TO mastodon;
\q
# 把 /home/mastodon/mastodon/postgres/mastodon.dump.xz 复制到新服务器 /home/mastodon/mastodon/postgres 并解压
# - 主机内
cd /home/mastodon/mastodon/postgres
xz -d mastodon.dump.xz
exit
# - 容器内 继续
cd /var/lib/postgresql/data
ls *.dump
pg_restore -U mastodon -n public --no-owner --role=mastodon -d mastodon mastodon.dump
exit
exit
# 数据库准备就绪

# 编译
cd /home/mastodon/mastodon
docker-compose down
docker-compose run --rm web rails assets:precompile #编译
# 清理，迁移文件夹 /home/mastodon/mastodon/public/system
docker-compose run --rm web bin/tootctl feeds build #构建用户首页时间流
docker-compose up -d
# 升级数据
docker-compose run --rm web rails db:migrate

# 赋权
cd /home/mastodon/mastodon
chown 991:991 -R ./public
chown -R 70:70 ./postgres
chown 1000:1000 -R ./elasticsearch # 如果启动了全文搜索

# 重启
docker-compose down
docker-compose up -d

# https://pullopen.github.io/%E7%AB%99%E7%82%B9%E7%BB%B4%E6%8A%A4/2020/10/21/migrate-Mastodon-to-Docker.html


# mastodon 升级
cd /home/mastodon/mastodon
docker pull tootsuite/mastodon:latest #或者将latest改成版本号如v3.2.1

docker-compose up -d
docker-compose run --rm web rails db:migrate
docker system prune -a

# 如果在操作过程中出现了任何问题……
docker-compose down
docker-compose up -d

# https://pullopen.github.io/%E5%9F%BA%E7%A1%80%E6%90%AD%E5%BB%BA/2020/10/19/Mastodon-on-Docker.html