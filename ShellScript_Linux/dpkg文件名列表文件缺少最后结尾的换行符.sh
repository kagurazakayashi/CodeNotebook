# dpkg: 无法恢复的致命错误，中止:
#  软件包 ucf 的文件名列表文件缺少最后结尾的换行符
ls ucf*
sudo rm -f /var/lib/dpkg/info/ucf* # 也可直接 rm -rf /var/lib/dpkg/info
sudo apt update
sudo apt upgrade -y

# 重新安装系统自带的全部软件，会全部刷新info目录:
sudo apt-get --reinstall install `dpkg --get-selections | grep '[[:space:]]install' | cut -f1`
