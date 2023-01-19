# Debian 设置或者修改时区

# 一、检查当前时区

# timedatectl是一个命令行工具，它允许你查看并且修改系统时间和日期。它在所有现代的基于 systemd 的 Linux 系统中都可以使用：
timedatectl

# 系统时区通过链接文件/etc/localtime配置，该链接指向/usr/share/zoneinfo目录下的一个二进制时区标识文件。另外一个检查时区的方法就是显示这个链接文件指向的实际路径，使用ls命令：
ls -l /etc/localtime

# 二、在 Debian 中修改时区

# 想要列出所有可用的时区，你可以列出/usr/share/zoneinfo目录下的所有文件，或者运行timedatectl命令，加上list-timezones选项：
timedatectl list-timezones

# 以 root 或者其他有 sudo 权限的用户身份，运行下面的命令修改时区：
sudo timedatectl set-timezone Asia/Shanghai
timedatectl

# 三、如果 timedatectl 在你的系统上不可用

# 你可以通过修改时区的链接文件/etc/localtime到/usr/share/zoneinfo目录下的时区文件来修改时区。
ls /usr/share/zoneinfo/Asia/Shanghai
sudo ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# 验证修改：
ls -l /etc/localtime
date
