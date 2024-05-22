# 开机时以root权限运行命令

# 使用 /etc/rc.local 文件
sudo nano /etc/rc.local
# 在文件中添加你想要执行的命令。确保这些命令前面不需要加 sudo，因为它们将以 root 权限运行。
# 在文件最后加上 exit 0。
# 确保该文件具有执行权限：
sudo chmod +x /etc/rc.local
# 重新启动你的系统以测试是否一切正常。

# 使用计划任务
sudo crontab -e
# 添加一行来运行你的命令，如下所示：
@reboot /path/to/your/script.sh

# 安装 Cron
sudo pacman -S cronie
sudo systemctl enable --now cronie.service

# 设置 Nano 为默认的 Cron 编辑器
nano ~/.bashrc  # 如果你使用 Bash
# 或者
nano ~/.zshrc   # 如果你使用 Zsh
# 然后在文件末尾添加以下行：
export EDITOR=nano
