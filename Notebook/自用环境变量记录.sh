vim ~/.bash_profile
echo "source ~/.bash_profile" >>~/.zshrc

# WSL
export NO_PROXY=localhost,127.0.0.1,::1
export DISPLAY=127.0.0.1:0
export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8

export ANDROID_HOME=/mnt/d/AndroidSDK
export FLUTTER_ROOT=/mnt/c/Flutter_Linux
export GOPATH=/mnt/d/go
export GOROOT=/mnt/c/Go_Linux
export GRADLE_USER_HOME=/mnt/e/gradle
export PATH="/home/yashi/bat:$ANDROID_HOME/platform-tools:$GOPATH/bin:$FLUTTER_ROOT/bin:$FLUTTER_ROOT/bin/cache/dart-sdk/bin:$PATH"

# MAC
export NO_PROXY=localhost,127.0.0.1,::1
export DISPLAY=127.0.0.1:0
export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8
export CHROME_EXECUTABLE="/Volumes/MACAPP/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

export ANDROID_HOME=/Volumes/MACAPP/AndroidSDK
export FLUTTER_ROOT=/Volumes/MACAPP/flutter
export GOPATH=/Volumes/MACAPP/c/go
export GOROOT=/Volumes/MACAPP/go
export GRADLE_USER_HOME=/Volumes/MACAPP/gradle
export PATH="$ANDROID_HOME/platform-tools:$GOPATH/bin:$FLUTTER_ROOT/bin:$FLUTTER_ROOT/bin/cache/dart-sdk/bin:$PATH"
