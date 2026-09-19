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

# 对比配置(镜像版本有无变动)
mousepad ../docker-compose.yml & mousepad docker-compose.yml

# 还原配置
cat ../docker-compose.yml >docker-compose.yml
cat ../env.production >.env.production

# 修改字数上限到 50000
sed -i 's/500/50000/g' /home/mastodon/mastodon/app/javascript/mastodon/features/compose/components/compose_form.jsx # 旧: /js
sed -i 's/500/50000/g' /home/mastodon/mastodon/app/validators/status_length_validator.rb

# 下载不了镜像：开代理
curl -I -x http://192.168.255.1:23334 https://registry-1.docker.io/v2/
curl -I -x http://192.168.255.1:23334 https://auth.docker.io/
# 有 401 404 之类的表示连上了
sudo vim /etc/systemd/system/docker.service.d/http-proxy.conf
# 没有则创建，内容：
[Service]
Environment="HTTP_PROXY=http://192.168.255.1:23334"
Environment="HTTPS_PROXY=http://192.168.255.1:23334"
Environment="NO_PROXY=localhost,127.0.0.1"
# 结束编辑，重载服务
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl show docker --property=Environment

# 编译时传入外部代理
# 卡在 Get:38 http://deb.debian.org/debian 时
export HTTP_PROXY=http://192.168.255.1:23334
export HTTPS_PROXY=http://192.168.255.1:23334
export NO_PROXY=localhost,127.0.0.1,::1,192.168.0.0/16,10.0.0.0/8

BUILDKIT_PROGRESS=plain docker compose build \
  --build-arg HTTP_PROXY="$HTTP_PROXY" \
  --build-arg HTTPS_PROXY="$HTTPS_PROXY" \
  --build-arg NO_PROXY="$NO_PROXY" \
  --build-arg http_proxy="$HTTP_PROXY" \
  --build-arg https_proxy="$HTTPS_PROXY" \
  --build-arg no_proxy="$NO_PROXY"

# 不需要代理用普通编译
docker-compose build

# 导出到生产服务器
mkdir -p ~/md
docker save yashi/mastodon-web | xz -z -1 -T 0 -v -c >~/md/yashi_mastodon-web.tar.xz
docker save yashi/mastodon-streaming | xz -z -1 -T 0 -v -c >~/md/yashi_mastodon-streaming.tar.xz
docker save yashi/mastodon-sidekiq | xz -z -1 -T 0 -v -c >~/md/yashi_mastodon-sidekiq.tar.xz
xz -z -e -9 docker-compose.yml -c >~/md/docker-compose.yml.xz
xz -z -e -9 .env.production -c >~/md/env.production.xz

# 生产服务器
cd /home/mastodon/mastodon
# 上传文件，解压导入
xz -d -v -c yashi_mastodon-web.tar.xz | docker load
xz -d -v -c yashi_mastodon-streaming.tar.xz | docker load
xz -d -v -c yashi_mastodon-sidekiq.tar.xz | docker load
# 启动看看输出
docker-compose up

# 故障.gif + web_1 | Information for: ActionView::Template::Error (undefined method 'collection_limit' for an instance of UserRole) ...
# 在生产服务器上升级数据库
cd /home/mastodon/mastodon
docker-compose down
# 执行全部数据库迁移
docker-compose run --rm web bundle exec rails db:migrate
# 启动看看输出
docker-compose up

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

# 清理构建缓存
docker builder prune
# 更彻底地清理（包括那些被其他镜像引用的缓存）
docker builder prune -a

# 清理悬空镜像
# 每次重新构建镜像时，旧的镜像标签会被移动到新镜像上，导致旧镜像变成没有标签的“悬空镜像”（显示为 <none>:<none>）。清理它们能释放大量空间：
docker image prune

# 一键清理(停止的容器也会遭到清理)
docker system prune

# 更新 Nginx: Docker/升级Nginx和PHP.md
