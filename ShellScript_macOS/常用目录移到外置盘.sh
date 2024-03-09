# 用移动硬盘分担系统盘数据（自用）
mkdir /Volumes/d/Applications
mkdir -p /Volumes/d/Users/yashi/Library
mkdir -p /Volumes/d/Users/yashi/
mkdir -p /Volumes/d/usr/local
# Documents
sudo mv /Users/yashi/Pictures /Volumes/d/Users/yashi/Pictures
sudo ln -s /Volumes/d/Users/yashi/Pictures /Users/yashi/Pictures
sudo mv /Users/yashi/Documents /Volumes/d/Users/yashi/Documents
sudo ln -s /Volumes/d/Users/yashi/Documents /Users/yashi/Documents
sudo mv /Users/yashi/Music /Volumes/d/Users/yashi/Music
sudo ln -s /Volumes/d/Users/yashi/Music /Users/yashi/Music
sudo mv /Users/yashi/Movies /Volumes/d/Users/yashi/Movies
sudo ln -s /Volumes/d/Users/yashi/Movies /Users/yashi/Movies
# Caches
sudo mv /Users/yashi/Library/Caches /Volumes/d/Users/yashi/Library/Caches
sudo ln -s /Volumes/d/Users/yashi/Library/Caches /Users/yashi/Library/Caches
# Android & gradle
sudo mv /Users/yashi/Library/Android /Volumes/d/Users/yashi/Library/Android
sudo ln -s /Volumes/d/Users/yashi/Library/Android /Users/yashi/Library/Android
sudo mv /Users/yashi/Library/Developer /Volumes/d/Users/yashi/Library/Developer
sudo ln -s /Volumes/d/Users/yashi/Library/Developer /Users/yashi/Library/Developer
sudo mv /Users/yashi/.gradle /Volumes/d/Users/yashi/gradle
sudo ln -s /Volumes/d/Users/yashi/gradle /Users/yashi/.gradle
# vscode
sudo mv /Users/yashi/.vscode /Volumes/d/Users/yashi/vscode
sudo ln -s /Volumes/d/Users/yashi/vscode /Users/yashi/.vscode
# brew
sudo mv /usr/local/Caskroom /Volumes/d/usr/local/Caskroom
sudo ln -s /Volumes/d/usr/local/Caskroom /usr/local/Caskroom
# Cellar
sudo mv /usr/local/Cellar /Volumes/d/usr/local/Cellar
sudo ln -s /Volumes/d/usr/local/Cellar /usr/local/Cellar

# echo source ~/.bash_profile >>.zshrc
# vim ~/.bash_profile
export CHROME_EXECUTABLE="/Volumes/d/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
export ANDROID_HOME=/Volumes/d/Users/yashi/Library/Android/sdk
export FLUTTER_ROOT=/Volumes/d/usr/local/Caskroom/flutter/3.19.3/flutter
export GOPATH=/Volumes/d/c
export GOROOT=/Volumes/d/usr/local/Cellar/go/1.22.1/libexec
export GRADLE_USER_HOME=/Volumes/d/Users/yashi/gradle
export PATH="$ANDROID_HOME/platform-tools:$GOPATH/bin:$FLUTTER_ROOT/bin:$FLUTTER_ROOT/bin/cache/dart-sdk/bin:$PATH"
