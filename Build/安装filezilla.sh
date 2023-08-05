# 安装FileZilla
apt-get install filezilla filezilla-locales -y

# 手动安装
wget https://dl3.cdn.filezilla-project.org/client/FileZilla_3.65.0_x86_64-linux-gnu.tar.xz
tar -Jxvf FileZilla_3.65.0_x86_64-linux-gnu.tar.xz
mv FileZilla3 ~/
vim /usr/share/applications/filezilla.desktop

# [Desktop Entry]
# Encoding=UTF-8
# Name=FileZilla
# Comment=Ftp Client
# Exec=~/FileZilla3/bin/filezilla
# Icon=~/FileZilla3/share/pixmaps/filezilla.png
# Terminal=false
# Type=Application
# CateGories=Application;Network;
# StartupNotify=true

cp /usr/share/applications/filezilla.desktop ~/Desktop
