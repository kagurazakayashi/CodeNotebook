# 安装AndroidSDK

# 安装JAVA JDK
apt update
apt install openjdk-17-jdk -y
update-alternatives --display java

# 配置环境变量PATH  vim ~/.zshrc
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export ANDROID_HOME=/mnt/d/AndroidSDK
export PATH=$PATH:$JAVA_HOME/bin:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools
cd $JAVA_HOME

# 下载命令行工具
# https://developer.android.com/studio?hl=zh-cn
cd $ANDROID_HOME
curl "https://dl.google.com/android/repository/commandlinetools-linux-14742923_latest.zip?hl=zh-cn" -o commandlinetools.zip
unzip commandlinetools.zip
rm commandlinetools.zip
mv cmdline-tools latest

# 更新 cmdline-tools 核心包 sdkmanager 和 接受协议
cd $ANDROID_HOME/latest/bin
./sdkmanager --version
yes | ./sdkmanager --sdk_root=$ANDROID_HOME --licenses
./sdkmanager --sdk_root=$ANDROID_HOME "cmdline-tools;latest"
cd $ANDROID_HOME
sdkmanager --version
yes | sdkmanager --sdk_root=$ANDROID_HOME --licenses
rm -rf latest
rm -rf latest

# 强制更新现有工具
yes | sdkmanager --update

# sdkmanager 会自动跳过已完整下载的包。
# 下载所有 Platform SDK (API 7 到最新)
sdkmanager --sdk_root=$ANDROID_HOME --list | grep "platforms;android-" | awk '{print $1}' | xargs -i sh -c "yes | sdkmanager '{}'"
# 下载所有 Build-Tools (构建工具)
sdkmanager --sdk_root=$ANDROID_HOME --list | grep "build-tools;" | awk '{print $1}' | xargs -i sh -c "yes | sdkmanager '{}'"
# 下载 Platform-Tools (即 adb, fastboot)
sdkmanager --sdk_root=$ANDROID_HOME "platform-tools"

# 巨大文件
# 下载所有 Google APIs 镜像 (x86_64 架构): 适用于 Windows 电脑和 Intel 芯片的 Mac。
sdkmanager --sdk_root=$ANDROID_HOME --list | grep "system-images;android-.*" | grep "google_apis" | grep "x86_64" | awk '{print $1}' | xargs -i sh -c "yes | sdkmanager '{}'"
# 下载所有 Google APIs 镜像 (arm64-v8a 架构): 适用于 Apple Silicon (M1/M2/M3) 芯片的 Mac。
sdkmanager --sdk_root=$ANDROID_HOME --list | grep "system-images;android-.*" | grep "google_apis" | grep "arm64-v8a" | awk '{print $1}' | xargs -i sh -c "yes | sdkmanager '{}'"
# 下载所有版本的 源码 (Sources) （可选）
sdkmanager --sdk_root=$ANDROID_HOME --list | grep "sources;android-" | awk '{print $1}' | xargs -i sh -c "yes | sdkmanager '{}'"
# 下载所有 Extras 库 (Google Play Services, Maven 仓库等) （可选）
sdkmanager --sdk_root=$ANDROID_HOME "extras;google;m2repository" "extras;android;m2repository" "extras;google;google_play_services"

# 赋予递归读写权限
chmod -R 775 $ANDROID_HOME
# 如果 Samba 用户不是 root，确保所有者正确
# chown -R 用户名:用户名 $ANDROID_HOME
