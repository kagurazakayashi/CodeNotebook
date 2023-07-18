# Misskey安装
# 安装 docker 和 docker-compose。

# 将 Misskey 克隆至本地并同步 master
git clone -b master https://github.com/misskey-dev/misskey.git
cd misskey
git checkout master

# 修改配置文档
# 执行以下命令来复制并重命名配置文档们:
cp .config/docker_example.yml .config/default.yml
cp .config/docker_example.env .config/docker.env
cp ./docker-compose.yml.example ./docker-compose.yml
ln -s .config config
# 根据文件中的说明编辑 default.yml 和 docker.env。如有必要，编辑 docker-compose.yml（如果要更改某些端口）。
vim .config/default.yml
vim .config/docker.env
vim ./docker-compose.yml

# Unknown flag: link
vim Dockerfile
# 把所有 COPY --link 替换为 COPY

# failed to parse platform : "" is an invalid component of "": platform specifier component must match ...
vim Dockerfile
# 把所有 --platform= 后面改为 linux/amd64

# 编译与初始化
# 执行以下命令以开始编译 Misskey 并初始化数据库，这需要一些时间。
docker-compose build
docker-compose run --rm web pnpm run init

# 单独卷存设置的话
cp config/* /var/lib/docker/volumes/misskey_config/_data/
docker-compose run --rm web pnpm run init

# 您可以使用以下命令启动 Misskey。
docker-compose up -d

# 如何更新
git stash
git checkout master
git pull
git submodule update --init
git stash pop
docker-compose build
docker-compose stop
docker-compose up -d

# 如何执行 CLI 命令
docker-compose run --rm web node packages/backend/built/tools/foo bar


# https://misskey-hub.net/zh-CN/docs/install/docker.html
