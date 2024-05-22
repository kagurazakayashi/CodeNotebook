# Ubuntu 开启性能模式

# 首先，需要安装 cpufrequtils 工具来管理 CPU 频率：
sudo apt update
sudo apt install cpufrequtils

# 安装完成后，可以列出可用的 CPU 调节器：
cpufreq-info -g

# 使用以下命令将所有 CPU 核心设置为“性能”模式：
sudo cpufreq-set -r -g performance

# 你可以使用以下命令验证当前的 CPU 调节器：
cpufreq-info

# 为了在每次启动时保持“性能”模式，可以将设置添加到 /etc/rc.local 文件中（如果文件不存在，可以创建它）：
sudo nano /etc/rc.local

# 在文件中添加以下行：
#!/bin/sh -e
cpufreq-set -r -g performance
exit 0

# 保存并退出编辑器，然后给予文件执行权限：
sudo chmod +x /etc/rc.local


# 持久化方法2
# 安装sysfsutils：
sudo apt-get install sysfsutils
# 编辑/etc/sysfs.conf ，增加如下语句：
devices/system/cpu/cpu0/cpufreq/scaling_governor = performance



# ArchLinux 开启性能模式

# 首先，需要安装 cpupower 工具来管理 CPU 频率：
sudo pacman -S cpupower

# 安装完成后，可以列出可用的 CPU 调节器：
cpupower frequency-info --governors

# 使用以下命令将所有 CPU 核心设置为“性能”模式：
sudo cpupower frequency-set -g performance

# 你可以使用以下命令验证当前的 CPU 调节器：
cpupower frequency-info

# 为了在每次启动时保持“性能”模式，可以启用并配置 cpupower 服务：
sudo nano /etc/default/cpupower

# 确保其中有以下内容：
# Define CPUs governor
governor='performance'

# 保存并退出编辑器，然后启用并启动 cpupower 服务：
sudo systemctl enable cpupower.service
sudo systemctl start cpupower.service
