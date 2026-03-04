# 调整显示器色彩

# 查看显示器名称（例如 HDMI-1 / eDP-1）：
xrandr

# 降低饱和度本质上等价于升高 RGB gamma：
xrandr --output eDP-1 --gamma 1.5:1.5:1.5

# 亮度
xrandr --output eDP-1 --brightness 0.9

# 暖色（偏黄）：
xrandr --output eDP-1 --gamma 1.0:0.9:0.8

# 冷色（偏蓝）：
xrandr --output eDP-1 --gamma 0.9:0.95:1.1

# 开关显示器
xrandr --output eDP-1 --off
xrandr --output eDP-1 --auto

# 缩放
xrandr --output eDP-1 --scale 1.25x1.25

# 自然柔和
xrandr --output eDP-1 --gamma 0.75:0.75:0.75 --brightness 0.93

# 暖色护眼
xrandr --output eDP-1 --gamma 1.0:0.9:0.8 --brightness 0.95

# 去鲜艳（模拟降低饱和度）
xrandr --output eDP-1 --gamma 0.8:0.8:0.8 --brightness 0.9
