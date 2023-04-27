# 安装CocoaPods
# 安装顺序是homebrew->gpg->rvm->ruby-cocoapods

# 安装Homebrew
git config --global --add safe.directory /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core
git config --global --add safe.directory /usr/local/Homebrew/Library/Taps/homebrew/homebrew-cask
brew --version

# 通过 Homebrew 安装 gpg rvm
brew install gpg rvm

# 把Ruby官方镜像改为国内镜像
sudo gem update --system
gem -v
gem sources -l
gem sources --remove https://rubygems.org/
gem sources --add https://gems.ruby-china.com/
gem sources -l

# 通过 Homebrew 安装 ruby
brew install ruby
which -a ruby
echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
which -a ruby
ruby -v

# 正式开始安装CocoaPods
sudo gem uninstall cocoapods
# sudo gem install cocoapods # Mac OS X 10.11前
sudo chmod +rx /usr/local/bin/
sudo gem install -n /usr/local/bin cocoapods
pod --version
# 将所有第三方的Podspec索引文件更新到本地的~/.cocoapods/repos目录下
pod setup
# pod setup的本质就是:
git clone https://github.com/CocoaPods/Specs.git ~/.cocoapods/repos/master

# https://www.jianshu.com/p/dbfdece084d5

# 通过梯子：sudo -s 执行代理环境变量后执行 sudo 相关命令后退出。

# 致命错误：无法访问 'https://github.com/CocoaPods/Specs.git/'：HTTP/2 stream 1 was not closed cleanly before end of the underlying stream
git config --global http.version HTTP/1.1
