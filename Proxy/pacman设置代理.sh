# pacman代理设置

vim /etc/pacman.conf

# 找到 [options] 节，添加
XferCommand = /usr/bin/curl -L -C - --proxy "http://host:23335" -v -f -o %o %u

# 源文件里有 XferCommand = 示例

pacman -Syy
pacman -Syu
