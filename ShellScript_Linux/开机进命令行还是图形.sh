# 修改默认启动级别 启动到命令行

# 主机默认启用图形模式
systemctl set-default graphical
# 主机默认启用命令行模式
systemctl set-default multi-user

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
systemctl isolate graphical.target
# 如果 isolate graphical.target 无法启动图形界面，可能是图形界面相关的服务（如 gdm 或 sddm）未运行，可以尝试手动启动它：
systemctl start gdm    # 如果使用 GNOME 桌面
systemctl start sddm   # 如果使用 KDE Plasma
systemctl start lightdm  # 如果使用 Xfce、LXQt 或其他桌面环境

# 开机以命令模式启动，执行：
systemctl set-default multi-user.target

# 开机以图形界面启动，执行：
systemctl set-default graphical.target

# 切换控制台
# Ctrl+Alt+F1、Ctrl+Alt+F2、...、Ctrl+Alt+F7
# 其中 7 是图形
