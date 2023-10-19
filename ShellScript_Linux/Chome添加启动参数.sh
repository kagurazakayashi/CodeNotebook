# Linux Chome添加启动参数

sudo vim /usr/share/applications/google-chrome.desktop
sudo vim /usr/share/applications/chromium.desktop
# 搜索所有 Exec ：
# Exec=/usr/bin/google-chrome-stable --disk-cache-dir="/home/yashi/ramdisk" --ignore-certificate-errors

# disk-cache-dir 配置缓存文件夹
# ignore-certificate-errors 证书有问题不拦截
