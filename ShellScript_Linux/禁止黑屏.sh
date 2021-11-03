# 在 X 图形界面下关闭屏幕保护程序：
xset s off

# 文本终端模式下，由于 Linux 默认支持显示器的 VESA powersaving features，键盘鼠标维持几分钟不操作显示器会自动黑屏，可以通过 setterm 命令禁用省电模式：
setterm -powersave off -blank 0

# 一般来说，可以通过如下命令来禁用（必须从控制台输入）：
setterm -powersave off -powerdown 0 -blank 0

# 如果想从ssh session来设置的话,可执行如下命令：
sh -c 'setterm -blank 0 -powersave off -powerdown 0 < /dev/console > /dev/console 2>&1'



# 立即关闭屏幕

# /sys 文件方式：
sudo tee /sys/class/backlight/intel_backlight/brightness <<< 0
# 亮度值根据情况选择，一般 0 即为关闭。

# xset 命令方式：
xset dpms force off
