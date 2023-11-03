# Centos7 搭建 Mastodon 长毛象 实例
https://www.rin404.com/Building/BTmastodon.html

# 加入建表权限
psql -h 127.0.0.1 -p 5432 -U postgres
CREATE USER mastodon CREATEDB;
ALTER USER mastodon CREATEDB;
\q

# 错误处理

# cld3 package configuration for protobuf is not found
yum install protobuf-devel -y

# An error occurred while installing pg
apt-get install libpq-dev
yum install postgresql-devel -y

# An error occurred while installing idn-ruby
yum install libidn libidn2 libidn2-devel -y

# 上传图片失败
yum install ImageMagick -y

# Unable to load application: NameError: uninitialized constant ActiveRecordQueryTrace
gem install rails
rake migrate
# NameError: uninitialized xxx
gem install xxx

# You have already activated rake 12.3.2, but your Gemfile requires rake 12.3.3
gem install rake

# /var/run/postgresql
ln -s /tmp/.s.PGSQL.5432 /var/run/postgresql/.s.PGSQL.5432

# 服务启动失败 Failed to start mastodon-web.
which bundle
# /home/mastodon/.rvm/gems/ruby-2.6.5/bin/bundle
cp /home/mastodon/live/dist/mastodon-*.service /etc/systemd/system/
vim /etc/systemd/system/mastodon-web.service
vim /etc/systemd/system/mastodon-sidekiq.service
vim /etc/systemd/system/mastodon-streaming.service

# mastodon-streaming.service 服务启动失败，直接运行报 Error: Cannot find module '../dist/bindings/cws_linux_57'
# https://discourse.joinmastodon.org/t/mastodon-streaming-service-failed-error-cannot-find-module-dist-bindings-cws-linux-57/2832
vim /home/mastodon/live/mastodon-streaming-start.sh
# #!/bin/bash
# \. /home/mastodon/.nvm/nvm.sh
# npm start
chmod +x mastodon-streaming-start.sh
vim /etc/systemd/system/mastodon-streaming.service
# ExecStart=/home/mastodon/live/mastodon-streaming-start.sh
systemctl daemon-reload
systemctl restart mastodon-streaming
systemctl status mastodon-streaming -l
# /home/mastodon/.nvm/nvm.sh: 没有那个文件或目录
# 安装 nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.0/install.sh | bash
# vim 根据环境选 ~/.bash_profile, ~/.zshrc, ~/.profile, ~/.bashrc 输入（正常已自动写入）
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# -> 修复权限
# 继续执行
/home/mastodon/.nvm/nvm.sh
chmod +x /home/mastodon/.nvm/nvm.sh
yarn install --pure-lockfile
# git ls-remote ssh://git@github.com/Gargron/emoji-mart.git Permission denied (publickey).
# 给 github 加 SSH

# uninitialized constant ActiveRecordQueryTrace
bundle install --deployment --with development

systemctl start mastodon-web.service
cd /home/mastodon/live
/home/mastodon/.rvm/gems/ruby-2.6.5/bin/bundle exec puma -C config/puma.rb

systemctl start mastodon-sidekiq.service
cd /home/mastodon/live
/home/mastodon/.rvm/gems/ruby-2.6.5/bin/bundle exec sidekiq -c 25

systemctl status mastodon-web.service -l
systemctl status mastodon-sidekiq.service -l
systemctl status mastodon-streaming.service -l

# mastodon uninitialized constant ActiveRecordQueryTrace
bundle install --deployment --with development

# 修复权限
chown -R mastodon:mastodon /home/mastodon/live
# docker权限
chmod -R 755 /home/mastodon/live
chown -R 991:991 /home/mastodon/live/public
# 软连接时更新源文件权限

# 将用户加入到www组
usermod -a -G www mastodon

# 安装完成
This configuration will be written to .env.production

# 主题
# 草莓象 https://github.com/ragingscholar/strawberry_theme
# 新草莓象 https://github.com/shioko/mastodon-strawberry
# 安装
cd strawberry_theme
cat strawberry.scss > ~/live/app/javascript/styles/strawberry.scss
cp elephant.png ~/live/public/strawberry/elephant.png
echo "strawberry: styles/strawberry.scss" >> ~/live/config/themes.yml
cd ~/live
# 补回
cp ~/strawberry-bak/themes.yml ~/live/config/themes.yml
cp -r ~/strawberry-bak/strawberry ~/live/app/javascript/styles/
cp ~/strawberry-bak/strawberry_full.scss ~/live/app/javascript/styles/strawberry_full.scss
# 重新编译
RAILS_ENV=production bundle exec rails assets:precompile
RAILS_ENV=production rails assets:precompile

# bundle 命令安装
cd /home/mastodon/live
gem install bundler
# rbenv: version `2.6.6' is not installed (set by /home/mastodon/live/.ruby-version)
rbenv install -l # 列出可安装版本
# 安装你需要的ruby版本(例如)：
rbenv install 2.6.6
# 只会在这个特定的文件夹中使用这个ruby版本:
rbenv local 2.6.6
# 如果没有需要的版本
cd /home/mastodon/.rbenv/plugins/ruby-build && git pull && cd -

# 更新升级
# 优先按照 GitHub 上每个版本更新说明操作！
# https://github.com/tootsuite/mastodon/releases/
# https://docs.joinmastodon.org/admin/upgrading/
cd /home/mastodon/live
systemctl stop mastodon-web
systemctl stop mastodon-sidekiq
systemctl stop mastodon-streaming
git reset --hard HEAD #撤销本地修改
git fetch
git checkout master
git fetch
git pull
git checkout $(git tag -l | grep -v 'rc[0-9]*$' | sort -V | tail -n 1)
bundle install -j$(getconf _NPROCESSORS_ONLN) --deployment --without development test
# 如果没有命令 -> bundle 命令安装
# 如果 node 版本不符 -> 用 n 切换
yarn install --pure-lockfile
RAILS_ENV=production bundle exec rails assets:precompile
/usr/bin/node ./streaming

# 停止
systemctl stop mastodon-web
systemctl stop mastodon-sidekiq
systemctl stop mastodon-streaming
systemctl stop postgresql
# 启动
systemctl start postgresql
systemctl start mastodon-streaming
systemctl start mastodon-sidekiq
systemctl start mastodon-web
# 状态
systemctl status postgresql -l
systemctl status mastodon-streaming -l
systemctl status mastodon-sidekiq -l
systemctl status mastodon-web -l
# 测试
cd /home/mastodon/live
/usr/bin/node ./streaming

#
su mastodon
export RAILS_ENV=production
# 永久 export
echo "export RAILS_ENV=production" >> ~/.bashrc
cd /home/mastodon/live
RAILS_ENV=production bin/tootctl help

# 配置文件
vim /home/mastodon/live/.env.production
# 备份
/www/server/pgsql/bin/pg_dump -h 127.0.0.1 -U mastodon -Fc mastodon -f backup.dump
/www/server/pgsql/bin/pg_dump -h 127.0.0.1 -U mastodon --coluwn-inserts -f mastodon.sql mastodon
# 还原
docker exec -it  mastodon_db_1 /bin/bash
su - postgres
createdb -T template0 mastodon_production
psql
    CREATE USER mastodon WITH PASSWORD '密码'; #没有密码则WITH PASSWORD部分不要。
    GRANT ALL PRIVILEGES ON DATABASE mastodon_production TO mastodon;
\q
pg_restore -U mastodon -n public --no-owner --role=mastodon -d mastodon_production backup.dump

# 在数据库直接更改主题
UPDATE `mastodon`.`settings` SET value = 'mastodon-light' WHERE id=9;

# docker 上清理
docker exec -it mastodon_web_1 /bin/bash
# 移除本地缓存的其它实例媒体附件
tootctl media remove --days 7 --concurrency 1
# 移除本地预览卡片缩略图
tootctl preview_cards remove --days 180 --concurrency 1 --verbose
# 从数据库中删除未被引用的嘟文
tootctl statuses remove --days 90
