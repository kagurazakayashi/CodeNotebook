#!/bin/bash

# 进程结束自动关机  提示用户选择操作类型
echo 进程监控电源操作 - 神楽坂雅詩
echo "请选择操作类型: "
echo "0. 显示通知"
echo "1. 关机"
echo "2. 重启"
echo "3. 睡眠"
echo "4. 休眠"
echo "5. 注销"
read -p "请输入对应数字 (0-5): " action

# 验证选择是否有效
if [[ -z "$action" ]]; then
  action=0
fi

if [[ $action -lt 0 || $action -gt 5 ]]; then
  echo "无效选择，请输入 0-5 的数字。"
  exit 1
fi

# 提示用户输入进程名称
read -p "请输入进程名称(如 7z ): " process_name
if [[ -z "$process_name" ]]; then
  echo "无效输入，请输入进程名称！"
  exit 1
fi

# 根据选择的操作类型设置操作名
case $action in
  0)
    operation="显示通知"
    ;;
  1)
    operation="关机"
    ;;
  2)
    operation="重启"
    ;;
  3)
    operation="睡眠"
    ;;
  4)
    operation="休眠"
    ;;
  5)
    operation="注销"
    ;;
esac

# 等待进程退出
while pgrep -x "$process_name" > /dev/null; do
  echo "进程 $process_name 正在运行，等待退出..."
  sleep 10
done

# 获取当前时间作为进程退出时间
end_time=$(date "+%Y-%m-%d %H:%M:%S")
echo "进程 $process_name 已退出，时间: $end_time，准备执行操作: $operation"

# 根据用户的选择执行相应操作
case $action in
  0)
    echo "进程 $process_name 已退出, 进程结束时间: $end_time"
    notify-send "进程 $process_name 已退出" "操作: $operation\n进程结束时间: $end_time"
    ;;
  1)
    echo "系统将关机..."
    shutdown now
    ;;
  2)
    echo "系统将重启..."
    reboot
    ;;
  3)
    echo "系统将进入睡眠模式..."
    systemctl suspend
    ;;
  4)
    echo "系统将进入休眠模式..."
    systemctl hibernate
    ;;
  5)
    echo "系统将注销..."
    gnome-session-quit --logout --no-prompt
    ;;
esac

exit 0
