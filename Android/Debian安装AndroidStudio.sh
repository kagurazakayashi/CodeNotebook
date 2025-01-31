# 在 Debian 系统上安装 Android Studio

# 解压安装包
cd ~/Downloads
tar -xvf android-studio-*-linux.tar.gz

# 移动到合适的位置
sudo mv android-studio /opt/

# 运行 Android Studio
/opt/android-studio/bin/studio.sh
# 首次运行会启动安装向导，按照提示安装必要的组件和 SDK。

# 添加 Android Studio 到 PATH
# 打开 .bashrc 或 .zshrc 文件添加以下内容
export PATH=$PATH:/opt/android-studio/bin

# 创建桌面快捷方式
cat <<EOF | sudo tee /usr/share/applications/android-studio.desktop
[Desktop Entry]
Version=1.0
Type=Application
Name=Android Studio
Exec="/opt/android-studio/bin/studio.sh" %f
Icon=/opt/android-studio/bin/studio.png
Categories=Development;IDE;
Terminal=false
EOF
