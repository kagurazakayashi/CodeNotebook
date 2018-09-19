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
