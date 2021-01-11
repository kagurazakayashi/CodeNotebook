brew install proxychains-ng
sudo vim /usr/local/etc/proxychains.conf
# 最后一行改成代理端口
# socks5 127.0.0.1 1080
# 使用
proxychains4 youtube-dl <URL>