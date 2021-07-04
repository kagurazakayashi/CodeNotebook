# 1.安装npm-check： （全局目录安装）
npm install -g npm-check

# 2.npm 全局更新包 (全局目录)
npm-check -u -g
# 通过上下键可以移动光标，使用空格键可以选择需要处理的包，回车直接进行处理。

# 3.npm更新某个项目的包 （项目目录）
npm-check -u
# 通过上下键可以移动光标，使用空格键可以选择需要处理的包，回车直接进行处理。
# 通过npm-check -u 就可以，不需要--save就可以直接更新package.json里面的内容

# 4.npm 更新单个全局包
npm update <name> -g

# 5.npm 更新 项目 生产环境依赖包
npm update <name> --save

# 6.npm 更新 项目 开发环境依赖包
npm update <name> --save-dev

# 7.npm 查找全局安装过的包
npm ls -g --depth 0
# Npm使用npm-check选择升级所有可更新包(全局+局部)

# 博客地址：https://blog.csdn.net/pcaxb/article/details/81773475