# 可用以命令显示当前系统安装的窗口管理器：
update-alternatives --display x-window-manager
# 用以下命令设置默认的启动项目：
update-alternatives --config x-window-manager
# 重启VNC服务
systemctl restart vncserver@1
# Xfce 一般用 xfwm4