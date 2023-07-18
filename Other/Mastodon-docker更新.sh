# 更新Mastodon更新
cd /home/mastodon/mastodon

# 备份配置
cat docker-compose.yml >../docker-compose.yml
cat .env.production >../env.production

docker-compose down
vim .env.production

git status
git restore .
git fetch
# git checkout [版本号]
git checkout v4.1.4

# 还原配置
cd ..
cat docker-compose.yml >mastodon/docker-compose.yml
cat env.production >mastodon/.env.production
cd mastodon

docker-compose build
docker-compose up -d

# 故障.gif
docker-compose down
docker-compose run --rm web rails assets:precompile #编译
docker-compose run --rm web bin/tootctl feeds build #构建用户首页时间流
docker-compose up -d
docker-compose run --rm web rails db:migrate

# ERROR: dockerfile parse error line 8: Unknown flag: link
# 去掉 docker-compose.yml 所有 --link
# 或者 ：https://github.com/docker/buildx#linux-packages :
mkdir buildx
cd buildx
vim Dockerfile
docker build .