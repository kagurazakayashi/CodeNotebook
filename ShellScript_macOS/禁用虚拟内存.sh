# mac虚拟内存禁用
csrutil disable # 重启电脑，按 Command + R 进入恢复模式，进行禁用
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.dynamic_pager.plist
sudo rm /private/var/vm/*
csrutil enable
# 打开：
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.dynamic_pager.plist


# 检查当前虚拟内存使用，如果在用重启电脑清除，如果都是0 说明系统暂时没有使用虚拟内存：
memory_pressure |grep Swap
# 进入放临时文件的目录
cd /private/var/vm
# 删除虚拟内存文件
sudo rm -R swapfile*
# 建立同名文件夹 使系统不能创建虚拟内存文件
sudo mkdir swapfile0 swapfile1 swapfile2 swapfile3 swapfile4 swapfile5