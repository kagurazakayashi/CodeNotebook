# WSL 使用 Windows 中已安装字体 安装中文字体

# 我们只需要将 Windows 下的字体目录链接到 WSL 目录下即可
sudo ln -s /mnt/c/Windows/Fonts /usr/share/fonts/font
# 再刷新一下
fc-cache -fv

# Linux 下查看已安装字体
fc-list :lang=zh