# 0：停机或者关机（千万不能将initdefault设置为0）
# 1：单用户模式，只root用户进行维护
# 2：多用户模式，不能使用NFS(Net File System)
# 3：完全多用户模式（标准的运行级别）
# 4：安全模式
# 5：图形化（即图形界面）
# 6：重启（千万不要把initdefault设置为6）

# 查看默认的target
systemctl get-default

# 暂时切换到图形模式
systemctl start lightdm

# 开机以命令模式启动，执行：
systemctl set-default multi-user.target

# 开机以图形界面启动，执行：
systemctl set-default graphical.target