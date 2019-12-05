# Centos7 搭建 Mastodon 实例
https://www.rin404.com/Building/BTmastodon.html

# 加入建表权限
psql -h 127.0.0.1 -p 5432 -U postgres
CREATE USER mastodon CREATEDB;
ALTER USER mastodon CREATEDB;
\q

# cld3 package configuration for protobuf is not found
yum install protobuf-devel -y

# An error occurred while installing pg
apt-get install libpq-dev
yum install postgresql-devel -y

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
vim /etc/systemd/system/mastodon-web.service
vim /etc/systemd/system/mastodon-sidekiq.service
vim /etc/systemd/system/mastodon-streaming.service

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
chown -R mastodon:mastodon live
chmod -R 755 live
cd live
chown -R 991:991 public/system
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
echo "strawberry: styles/strawberry.scs" >> ~/live/config/themes.yml
cd ~/live
# 补回
cp ~/strawberry-bak/themes.yml ~/live/config/themes.yml
cp -r ~/strawberry-bak/strawberry ~/live/app/javascript/styles/
cp ~/strawberry-bak/strawberry_full.scss ~/live/app/javascript/styles/strawberry_full.scss
# 重新编译
RAILS_ENV=production bundle exec rails assets:precompile
RAILS_ENV=production rails assets:precompile

# 更新
git reset --hard HEAD #撤销本地修改
git fetch
git checkout master
git fetch
git pull
git checkout $(git tag -l | grep -v 'rc[0-9]*$' | sort -V | tail -n 1)
bundle install -j$(getconf _NPROCESSORS_ONLN) --deployment --without development test
yarn install --pure-lockfile
RAILS_ENV=production bundle exec rails assets:precompile