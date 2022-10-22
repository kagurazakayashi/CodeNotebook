# 首先克隆一份原仓库到本地进行操作：
git clone xxxxxxx.git
# 创建并切换到main：
git checkout -b main
# 推送main：
git push origin main

# 修改默认分支

# Github 中进行操作，进入仓库的设置，点击分支选项
# Settings - branches - Default branch - 切换双箭头图标
# 将其中的默认分支修改为main，并点击右边的Update，点击Update后会有提示有可能会影响PR和克隆

# 删除本地master：
git branch -d master
# 删除远程master：
git push origin :master

# 这样就算成功迁移到 main 分支了。

# https://zhuanlan.zhihu.com/p/339370999
