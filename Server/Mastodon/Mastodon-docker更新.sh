# 检查最新版本
# https://github.com/mastodon/mastodon/releases

# 更新Mastodon更新
cd /home/mastodon/mastodon

# 备份配置
cat docker-compose.yml >../docker-compose.yml
cat .env.production >../env.production

docker-compose down
vim .env.production

git status
git restore .
git checkout main
git fetch
git pull
# git checkout [版本号] , 不 checkout 是 beta 版
git checkout v4.2.3

# 还原配置
cat ../docker-compose.yml >docker-compose.yml
cat ../env.production >.env.production

docker-compose up -d --build # = docker-compose build && docker-compose up -d

# 故障.gif
docker-compose down
docker-compose build
docker-compose run --rm web rails assets:precompile #编译
docker-compose run --rm -e SKIP_POST_DEPLOYMENT_MIGRATIONS=true web bundle exec rails db:migrate # 数据库迁移
docker-compose run --rm web bin/tootctl feeds build #构建用户首页时间流
docker-compose up
# Ctrl+C
docker-compose run --rm web bundle exec rails db:migrate # 数据库迁移
docker-compose up -d

# ERROR: dockerfile parse error line 8: Unknown flag: link
# 去掉 docker-compose.yml 所有 --link
sed -i 's/--link / /g' /home/mastodon/mastodon/Dockerfile
# 或者 ：https://github.com/docker/buildx#linux-packages :
mkdir buildx
cd buildx
vim Dockerfile
docker build .

# 修改字数上限到 50000
sed -i 's/500/50000/g' /home/mastodon/mastodon/app/javascript/mastodon/features/compose/components/compose_form.jsx # 旧: /js
sed -i 's/500/50000/g' /home/mastodon/mastodon/app/validators/status_length_validator.rb

# 清理构建缓存
docker builder prune
# 更彻底地清理（包括那些被其他镜像引用的缓存）
docker builder prune -a

# 清理悬空镜像
# 每次重新构建镜像时，旧的镜像标签会被移动到新镜像上，导致旧镜像变成没有标签的“悬空镜像”（显示为 <none>:<none>）。清理它们能释放大量空间：
docker image prune

# 一键清理(停止的容器也会遭到清理)
docker system prune
