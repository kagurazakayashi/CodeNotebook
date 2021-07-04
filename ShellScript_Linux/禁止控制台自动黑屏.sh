# 一般来说，可以通过如下命令来禁用（必须从控制台输入）：
setterm -powersave off -powerdown 0 -blank 0

# 如果想从ssh session来设置的话,可执行如下命令：
sh -c 'setterm -blank 0 -powersave off -powerdown 0 < /dev/console > /dev/console 2>&1'