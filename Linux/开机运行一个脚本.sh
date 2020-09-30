crontab -e
# @reboot . /etc/profile; /bin/sh /boot.sh
# @reboot nohup /boot.sh
# nohup 是用来让运行的程序忽略 SIGHUP 指令（因为在父程序退出后，所有的子程序会受到 SIGHUP 指令）从而保证运行的程序不退出。
chmod +x /boot.sh
vim /boot.sh