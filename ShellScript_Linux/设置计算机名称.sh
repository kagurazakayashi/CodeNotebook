# 在 Linux 中设置计算机名（hostname）
sudo hostnamectl set-hostname 新的计算机名

sudo vim /etc/hostname
# 将里面的内容更改为你想要的新计算机名。

# 为了使更改生效，可能需要重启计算机或者运行以下命令：
sudo systemctl restart systemd-hostnamed

# 如果你只是想临时更改计算机名（重启后会恢复原状），可以使用 hostname 命令：
sudo hostname 新的计算机名

# 在终端中，只需输入 hostname 并回车会输出当前的计算机名。
hostname
echo $HOSTNAME
cat /etc/hostname
uname -n
# 以上任何一种方法都可以在 Bash 脚本或终端中使用来获取当前计算机的名字。通常，使用 hostname 命令是最直接的方式。
