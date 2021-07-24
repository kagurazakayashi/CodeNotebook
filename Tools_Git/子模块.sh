# 将远程项目 https://github.com/kagurazakayashi/yq.git 克隆到本地 yq 文件夹
git submodule add https://github.com/kagurazakayashi/yq.git yq
# 将子模块设定为指定分支 release
git submodule add https://github.com/kagurazakayashi/digital-numbers-font.git numbers
cd numbers
git checkout release
# git submodule add 会在本地项目根目录创建配置文件
cat .gitmodules
# [submodule "src/yq"]
#   path = src/yq
#   url = https://github.com/kagurazakayashi/yq.git
#   branch = main   # 指定分支的要在这里加上指定的分支，默认分支的话不用加

# 查看子模块
git submodule
# 78ff77391b006f07edacbabe89e4431328cabd54 src/yqfatal: no submodule mapping found in .gitmodules for path 'yq' (heads/master)

# 更新子模块
# 更新项目内子模块到最新版本
git submodule update
# 更新子模块为远程项目的最新版本
git submodule update --remote

# 克隆包含子模块的项目

# 克隆父项目再更新子模块
# 1. 克隆父项目
git clone https://github.com/maonx/vimwiki-assets.git assets
# 2. 查看子模块
git submodule
#  -e33f854d3f51f5ebd771a68da05ad0371a3c0570 assets
# 子模块前面有一个-，说明子模块文件还未检入（空文件夹）。
# 3. 初始化子模块
git submodule init
# Submodule 'assets' (https://github.com/maonx/vimwiki-assets.git) registered for path 'assets'
# 初始化模块只需在克隆父项目后运行一次。
# 4. 更新子模块
git submodule update

# 递归克隆整个项目：递归克隆整个项目，子模块已经同时更新了，一步到位。
git clone https://github.com/maonx/vimwiki-assets.git assets --recursive 

# 修改子模块
# 在子模块中修改文件后，直接提交到远程项目分支。
git add .
git ci -m "commit"
git push origin HEAD:master

# 删除子模块
# 删除子模块比较麻烦，需要手动删除相关的文件，否则在添加子模块时有可能出现错误
# 同样以删除assets文件夹为例
# 1. 删除子模块文件夹
git rm --cached assets
rm -rf assets
# 2. 删除 .gitmodules 文件中相关子模块信息
# [submodule "assets"]
#   path = assets
#   url = https://github.com/maonx/vimwiki-assets.git
# 3. 删除 .git/config 中的相关子模块信息
# [submodule "assets"]
#   url = https://github.com/maonx/vimwiki-assets.git
# 4. 删除.git文件夹中的相关子模块文件
rm -rf .git/modules/assets