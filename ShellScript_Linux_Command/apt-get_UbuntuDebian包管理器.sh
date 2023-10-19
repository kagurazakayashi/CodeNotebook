# 一、清理

sudo apt-get autoclean
# 如果你的硬盘空间不大的话，可以定期运行这个程序，将已经删除了的软件包的.deb安装文件从硬盘中删除掉。
# 如果你仍然需要硬盘空间的话，可以试试apt-get clean，这会把你已安装的软件包的安装包也删除掉，当然多数情况下这些包没什么用了，因此这是个为硬盘腾地方的好办法。

sudo apt-get clean
# 类似上面的命令，但它删除包缓存中的所有包。这是个很好的做法，因为多数情况下这些包没有用了。

sudo apt-get autoremove
# 删除为了满足其他软件包的依赖而安装的，但现在不再需要的软件包。

sduo apt-get remove 软件包名称
# 删除已安装的软件包（保留配置文件）

sudo apt-get --purge remove 软件包名称 
# 删除已安装包（不保留配置文件)


# 二、更新

sudo apt-get update
# 更新 /etc/apt/sources.list 和 /etc/apt/sources.list.d 中列出的源的地址,这样才能获取到最新的软件包

sudo apt-get upgrade
# 升级已安装的所有软件包，升级的版本就是更新的源地址里的版本，因此，在执行 upgrade 之前一定要执行 update, 这样才能更新到最新的


# 三、安装

sudo apt-get install -f 
# 参数为–fix-broken的简写形式，可以在man apt-get 中搜索-f参数查询到其帮助信息
# -f参数的主要作用是是修复依赖关系（depends），假如用户的系统上有某个package不满足依赖条件，这个命令就会自动修复，安装程序包所依赖的包。

sudo apt-get install 软件包名称
# 一般安装步骤（如安装atom时）:

# a. 一般安装软件前需要更新依赖库
sudo add-apt-repository ppa:webupd8team/atom

# b. 再更新源地址
sudo apt-get update

# c. 最后安装该软件
sudo apt-get install atom

# 离线安装:

# 下载软件
curl "url" -o "软件名称.deb"

# 安装已下载的软件（debain安装包.deb）
dpkg -i "./软件名称.deb"


# 四、卸载

# 先查看系统装了哪些软件
dpkg -l 

# 先卸载软件
sudo apt-get remove atom

# 再卸载依赖库
sudo add-apt-repository --remove ppa:webupd8team/atom

# 再使用 autoremove
sudo apt-get autoremove

# https://juejin.cn/post/7163855544552259591
