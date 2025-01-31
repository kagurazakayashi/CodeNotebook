# WSL 使用 Windows 中已安装字体 安装中文字体
# Windows字体安装到WSL安装Windows字体：
# 安装字体管理包
sudo apt-get install --assume-yes fontconfig
# 拷贝安装中文字体
sudo mkdir -p /usr/share/fonts/windows
sudo cp -r /mnt/c/Windows/Fonts/*.ttf /usr/share/fonts/windows/
# 不拷贝安装中文字体
sudo ln -s /mnt/c/Windows/Fonts /usr/share/fonts/windows
# 清除字体缓存
fc-cache -fv
# 生成中文环境
sudo locale-gen zh_CN.UTF-8
# Linux 下查看已安装字体
fc-list :lang=zh
