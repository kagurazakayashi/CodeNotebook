# git_stats
dnf install ruby gcc ruby-devel zlib-devel -y
gem install git_stats

# 在 git 仓库下运行
git_stats generate
# 会生成一个新目录 git_stats , 打开index.html就可以了