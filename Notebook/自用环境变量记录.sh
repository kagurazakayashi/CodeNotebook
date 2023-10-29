# 自用环境变量记录
vim ~/.bash_profile
echo "source ~/.bash_profile" >>~/.zshrc

# Windows
SET JAVA_HOME="C:\Program Files\Java\jdk-20"
SET ANDROID_HOME="D:\AndroidSDK"
SET ANDROID_SDK_HOME="D:\Android"
SET GRADLE_HOME="C:\ProgramData\chocolatey\lib\gradle\tools\gradle-8.1.1"
SET GRADLE_USER_HOME="D:\Android\gradle"
SET GOROOT="E:\SDK\go"
SET GOPATH="D:\c\go"
SET FLUTTER_ROOT="E:\SDK\flutter"
SET PATH="%PATH%;C:\Program Files\Git\bin;C:\Program Files\Git\cmd;%JAVA_HOME\jre\bin;%JAVA_HOME\bin;%ANDROID_HOME%\platform-tools;%ANDROID_HOME%\tools;%ANDROID_HOME%\build-tools\34.0.0;%GRADLE_HOME%\bin;%FLUTTER_ROOT%\bin;C:\tools\msys64\usr\bin;"

# Linux
export NO_PROXY=localhost,127.0.0.1,::1
export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export ANDROID_HOME=/sdk/android
export FLUTTER_ROOT=/sdk/flutter
export DART_ROOT=$FLUTTER_ROOT/bin/cache/dart-sdk
export GRADLE_HOME=/sdk/gradle
export GRADLE_USER_HOME=/sdk/gradledata
export GOROOT=/sdk/go
export GOPATH=/home/yashi/go
export PATH="$JAVA_HOME/bin:$ANDROID_HOME/platform-tools:$GOROOT/bin:$GOPATH/bin:$FLUTTER_ROOT/bin:$DART_ROOT/bin:$PATH"

# WSL
export NO_PROXY=localhost,127.0.0.1,::1
export DISPLAY=127.0.0.1:0
export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8

export ANDROID_HOME=/mnt/d/AndroidSDK
export ANDROID_SDK_HOME=/mnt/d/Android
export GRADLE_USER_HOME=/mnt/e/gradle
export GOPATH=/mnt/d/go
export GOROOT=/mnt/c/Go_Linux
export FLUTTER_ROOT=/mnt/c/Flutter_Linux
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
