# 查看当前环境shell
echo $SHELL
# 查看系统自带哪些shell
cat /etc/shells

# 安装zsh
yum install zsh # CentOS
brew install zsh # mac安装

# 将zsh设置为默认shell
chsh -s /bin/zsh # CentOS
# Mac如下
# 在 /etc/shells 文件中加入如下一行
/usr/local/bin/zsh
# 接着运行
chsh -s /usr/local/bin/zsh

# 可以通过echo $SHELL查看当前默认的shell，如果没有改为/bin/zsh，那么需要重启shell。

# 安装oh-my-zsh
# 1.自动安装
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
# 2.手动安装
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

# 通过如下命令可以查看可用的Theme：
ls ~/.oh-my-zsh/themes

# 如何修改zsh主题呢？
# 编辑~/.zshrc文件，将ZSH_THEME="candy",即将主题修改为candy。我采用的steeef。

# https://segmentfault.com/a/1190000013612471