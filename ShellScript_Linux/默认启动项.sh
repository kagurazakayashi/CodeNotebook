# RedHat7
# 查看默认启动的内核
grub2-editenv list
# 查看所有内核
cat /boot/grub2/grub.cfg | grep menuentry
# 修改最新内核为默认启动
grub2-set-default 'Red Hat Enterprise Linux Server (4.4.0) 7.2 (Maipo)'
# 验证默认启动内核
grub2-editenv list


# RedHat8
# 安装 grubby
dnf install grubby
# 查看默认启动项
grubby --default-kernel
# 查看所有内核
grubby --info=ALL
# 查看指定内核启动项
grubby --info=/boot/vmlinuz-4.18.0-80.7.1.el8_0.x86_64
# 修改默认启动
grubby --set-default /boot/vmlinuz-4.18.0-80.11.2.el8_0.x86_64
# 修改内核启动项参数
grubby --update-kernel=/boot/vmlinuz-4.18.0-80.7.1.el8_0.x86_64 --args=console=ttyS0,115200
# 直接修改文件
vim /boot/grub2/grubenv


# 其他
vim /etc/default/grub

# 设定默认启动项，推荐使用数字
GRUB_DEFAULT=0

# 注释掉下面这行将会显示引导菜单
#GRUB_HIDDEN_TIMEOUT=0

# 黑屏，并且不显示GRUB_HIDDEN_TIMEOUT过程中的倒计时
GRUB_HIDDEN_TIMEOUT_QUIET=true

# 设定超时时间，默认为10秒
# 设定为-1取消倒计时
GRUB_TIMEOUT=10

# 获得发行版名称（比如Ubuntu, Debian）
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`

# 将会导入到每个启动项（包括recovery mode启动项)的'linux'命令行
GRUB_CMDLINE_LINUX=""

# 同上，但是只会添加到 normal mode 的启动项
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"

# 取消注释以允许图形终端（只适合grub-pc）
#GRUB_TERMINAL=console

# 分辨率设定，否则采用默认值
#GRUB_GFXMODE=640x480

# 取消注释以阻止GRUB将传递参数 "root=UUID=xxx" 传递给 Linux
#GRUB_DISABLE_LINUX_UUID=true

# 取消启动菜单中的“Recovery Mode”选项
#GRUB_DISABLE_LINUX_RECOVERY="true"

# 当GRUB菜单出现时发出鸣音提醒
#GRUB_INIT_TUNE="480 440 1"

# https://blog.csdn.net/dc_show/article/details/47396649



# 新系统
cd /etc/grub.d && ls
# 修改各个配置
update-grub
grub-mkconfig -o /etc/default/grub
# 以上最终会生成 /etc/default/grub
