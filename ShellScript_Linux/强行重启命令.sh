# 强行重启命令
sudo reboot
# 当 sudo reboot 命令没有反应时，通常意味着系统已经严重卡死，正常的关机流程无法完成。

# 这是 Linux 内核提供的一种底层机制，即使在系统大部分功能无响应时，也可能生效。它允许你通过一系列指令，相对安全地重启系统。
# 操作步骤 (R-E-I-S-U-B 序列)
# 这个方法的核心是按顺序执行几个关键操作，以最大限度地减少数据损坏的风险。
# 按住 Alt 和 SysRq (通常是 PrintScreen) 键不放。
# 依次缓慢按下以下按键，每个按键之间间隔 1-2 秒：
# R: 将键盘从 X Server 等程序中夺回控制权 (Raw mode)。
# E: 向所有进程发送 SIGTERM 信号，请求它们优雅地终止。
# I: 向所有进程发送 SIGKILL 信号，强制结束剩余进程。
# S: 将所有缓存数据同步写入磁盘 (Sync)，防止数据丢失。
# U: 将所有文件系统重新以只读方式挂载 (Unmount/Remount-ro)，防止重启时进行文件系统检查。
# B: 立即重启系统 (Reboot)。
# 整个过程可以概括为口诀："Raising Elephants Is So Utterly Boring"。

read -p "要重启吗？(y/N) " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "操作已取消。"
    exit 1
fi
if [ "$(id -u)" -ne 0 ]; then
    echo "需要 root 。"
    exit 1
fi

# 尝试启用 Magic SysRq 功能
# 如果之前被禁用，此命令会临时开启它
echo "0/6 确保 SysRq 功能已开启..."
# echo 1 | sudo tee /proc/sys/kernel/sysrq
echo 1 > /proc/sys/kernel/sysrq 2>/dev/null
if [ $? -ne 0 ]; then
    echo "无法启用 Magic SysRq 功能，可能内核未编译支持或权限不足。"
    exit 1
fi
sleep 10

echo 开始 R-E-I-S-U-B 序列

echo "1/6 正在尝试夺取键盘控制权 (R)..."
echo r > /proc/sysrq-trigger
sleep 10

echo "2/6 正在请求所有进程优雅终止 (E)..."
echo e > /proc/sysrq-trigger
sleep 10

echo "3/6 正在强制杀死未响应的进程 (I)..."
echo i > /proc/sysrq-trigger
sleep 10

echo "4/6 正在同步内存数据到磁盘 (S)..."
echo s > /proc/sysrq-trigger
sleep 10

echo "5/6 正在将所有文件系统重新挂载为只读模式 (U)..."
echo u > /proc/sysrq-trigger
sleep 10

echo "6/6 准备重启系统 (B)..."
echo b > /proc/sysrq-trigger
sleep 10

echo "重启失败。"
read -p "要强制重启吗？(y/N) " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "操作已取消。"
    exit 1
fi
echo "7/7 准备强制重启系统..."
reboot -f
sleep 10
echo "重启失败。"
