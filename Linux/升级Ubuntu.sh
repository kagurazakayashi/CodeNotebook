# 升级安装包相关的命令,刷新可安装的软件列表(但是不做任何实际的安装动作)
apt-get update

# 进行安装包的更新(软件版本的升级)
apt-get upgrade

# 进行系统版本的升级(Ubuntu版本的升级)
apt-get dist-upgrade

# Ubuntu官方推荐的系统升级方式,若加参数-d还可以升级到开发版本,但会不稳定
do-release-upgrade
