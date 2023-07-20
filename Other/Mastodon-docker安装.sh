# Mastodon-docker安装

# 拉取Mastodon镜像
mkdir -p /home/mastodon/mastodon
cd /home/mastodon/mastodon
docker pull ghcr.io/mastodon/mastodon:latest     #如果需要升级到某稳定版本，请将latest改成v4.1.4等版本号。
wget https://raw.githubusercontent.com/mastodon/mastodon/main/docker-compose.yml
# 修改配置文件
vim docker-compose.yml
vim .env.production
# 可以用这个工具建立：
docker-compose run --rm web bundle exec rake mastodon:setup

# 初始化PostgreSQL
# docker-compose.yml 添加一条 environment ：
# - 'POSTGRES_PASSWORD=数据库管理员密码'
docker-compose up --build
docker exec -it mastodon_db_1 psql -U postgres
CREATE USER mastodon WITH PASSWORD 'mastodon数据库密码' CREATEDB;
\q
docker-compose down

# 配置 Nginx ： https://pullopen.github.io/%E5%9F%BA%E7%A1%80%E6%90%AD%E5%BB%BA/2020/10/19/Mastodon-on-Docker.html

