#清除npm缓存
npm cache clean --force

# 更新自身
npm i -g npm

# 更新包

# 手动更新:修改package.json中依赖包版本，执行
npm install --force

# 方法二:使用第三方插件：
npm install -g npm-check-updates
ncu # 查看可更新包
ncu -u # 更新package.json
npm install # 升级到最新版本

# 方法三:使用yarn代替npm
yarn upgrade


#node 更新：
#清除node缓存
npm cache clean -f
#安装node版本管理工具'n'
npm install n -g
#使用版本管理工具安装指定node或者升级到最新node版本
n stable
n 8.9.4


#软连接
rm -f /usr/local/bin/node /usr/local/bin/npm /usr/local/bin/npx
rm -f /usr/bin/node /usr/bin/npm /usr/bin/npx
ln -s /usr/local/n/versions/node/10.10.0/bin/node /usr/bin/node
ln -s /usr/local/n/versions/node/10.10.0/bin/npm /usr/bin/npm
ln -s /usr/local/n/versions/node/10.10.0/bin/npx /usr/bin/npx
ln -s /usr/local/n/versions/node/10.10.0/bin/node /usr/local/bin/node
ln -s /usr/local/n/versions/node/10.10.0/bin/npm /usr/local/bin/npm
ln -s /usr/local/n/versions/node/10.10.0/bin/npx /usr/local/bin/npx

#删除所有包
rm -rf /usr/lib/node_modules


#代理
npm config set proxy http://192.168.2.100:1080
npm config set https-proxy http://192.168.2.100:1080
