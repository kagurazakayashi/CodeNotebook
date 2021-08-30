# dpkg: 错误: fgets 从 /var/lib/dpkg/triggers/Unincorp 取回了一个空字符串
sudo rm /var/lib/dpkg/triggers/Unincorp
sudo touch /var/lib/dpkg/triggers/Unincorp
sudo dpkg --configure -a


dpkg: 错误: fgets 从 /var/lib/dpkg/triggers/update-initramfs 取回了一个空字符串
E: Sub-process /usr/bin/dpkg returned an error code (2)
正在读取软件包列表... 完成