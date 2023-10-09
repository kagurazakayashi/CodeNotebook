# 安装中文输入法
sudo apt remove "fcitx*" -y
sudo apt install fcitx5 fcitx5-chinese-addons fcitx5-frontend-gtk4 fcitx5-frontend-gtk3 fcitx5-frontend-gtk2 fcitx5-frontend-qt5 -y
mkdir -p ~/.local/share/fcitx5/pinyin/dictionaries/
cd ~/.local/share/fcitx5/pinyin/dictionaries/
# https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases 下载最新版的 [.dict] 文件
wget https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases/download/0.2.4/zhwiki-20230823.dict
# 重启

# 设置为默认输入法
# 使用 im-config 工具可以配置首选输入法，在任意命令行输入：
im-config
# 根据弹出窗口的提示，将首选输入法设置为 Fcitx 5 即可。

# 环境变量
# 需要为桌面会话设置环境变量，即将以下配置项写入某一配置文件中：
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
# 如果使用 Bash 作为 shell，则建议写入至 ~/.bash_profile ，这样只对当前用户生效，而不影响其他用户。
# 另一个可以写入此配置的文件为系统级的 /etc/profile 。

# https://zhuanlan.zhihu.com/p/508797663?utm_id=0
