# 禁止关屏 禁止休眠

# 禁止 Console（TTY）下的屏幕关闭/休眠
# 编辑 /etc/kbd/config 或 /etc/default/console-setup（依发行版而异）：
nano /etc/kbd/config
nano /etc/default/console-setup
# 添加或修改以下内容：
BLANK_TIME=0
POWERDOWN_TIME=0
# 然后重启或运行以下命令使其立即生效：
setterm -blank 0 -powerdown 0 -powersave off
# 建议将以下命令添加到 ~/.bashrc 或 /etc/profile.d/disable-blanking.sh 中，确保每次登录时设置生效：
setterm -blank 0 -powerdown 0 -powersave off > /dev/tty1

# 禁止 X11 图形界面下的屏幕关闭/休眠
# 你可以将以下命令写入自启动脚本，如 .xinitrc、~/.xprofile、系统自启动配置等：
xset s off              # 关闭屏幕保护
xset -dpms              # 禁用 DPMS（Display Power Management Signaling）
xset s noblank          # 禁用屏幕 blanking
# 可以用脚本验证：
xset q | grep -A 1 "Screen Saver"
xset q | grep "DPMS"

# Wayland 桌面环境（如 GNOME on Wayland）
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0

# 系统级别（不依赖 DE），禁止 Suspend/Sleep/Hibernate
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
# 如果之后你希望恢复：
sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target

# 检查 UPower 或 logind 控制行为（可选）查看当前设置
gsettings list-recursively org.freedesktop.UPower
loginctl show-session $XDG_SESSION_ID | grep IdleHint
