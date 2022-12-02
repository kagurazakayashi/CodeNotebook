# WSL-Debian无法联网
# wsl中debian无法连接到源
# Err:1 http://deb.debian.org/debian buster InRelease
#   Could not connect to debian.map.fastlydns.net
# W: Failed to fetch ...
# W: Some index files failed to download. They have been ignored, or old ones used instead.

# 修改dns服务器后就好了
sudo vi /etc/resolv.conf
# 把 nameserver 换成其他 DNS
# 重新启动一下网络：
sudo /etc/init.d/networking restart
