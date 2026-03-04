# SSH运行的GUI程序在主机屏幕上显示.sh

# 配置为允许这样做
xhost +local:

# 临时在显示器中启动 xeyes 软件
DISPLAY=:0 xeyes

# 配置为环境变量写到 ~/.zshrc 等
export DISPLAY=:0
