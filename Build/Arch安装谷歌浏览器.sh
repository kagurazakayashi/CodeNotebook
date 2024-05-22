# Arch安装谷歌浏览器
git clone https://aur.archlinux.org/google-chrome.git
cd google-chrome
makepkg -is

# 升级
git pull
makepkg -is
