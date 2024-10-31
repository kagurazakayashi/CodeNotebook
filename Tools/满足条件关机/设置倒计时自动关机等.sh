#!/bin/bash

# 倒计时自动关机  获取开始时间
start_time=$(date +"%Y-%m-%d %H:%M:%S")

# 菜单选择
echo "定时电源操作 - 神楽坂雅詩"
echo "请选择操作类型: "
echo "0. 显示通知(默认)"
echo "1. 关机"
echo "2. 重启"
echo "3. 睡眠"
echo "4. 休眠"
echo "5. 注销"
read -p "请输入对应数字 (0-5): " action

# 验证输入是否有效
if [[ -z "$action" ]]; then
  action=0
fi

if [[ $action -lt 0 || $action -gt 5 ]]; then
  echo "无效输入，退出程序。"
  exit 1
fi

# 输入倒计时时间
read -p "请输入倒计时的小时数 (默认0): " hour
read -p "请输入倒计时的分钟数 (默认0): " minute
read -p "请输入倒计时的秒数 (默认0): " second

# 默认值处理
hour=${hour:-0}
minute=${minute:-0}
second=${second:-0}

# 检查输入是否为数字
if ! [[ $hour =~ ^[0-9]+$ && $minute =~ ^[0-9]+$ && $second =~ ^[0-9]+$ ]]; then
  echo "输入的时间无效，请输入有效的数字！"
  exit 1
fi

# 将时间转换为总秒数
total_seconds=$((hour * 3600 + minute * 60 + second))

# 根据选择设置操作描述
case $action in
  0) operation="显示通知" ;;
  1) operation="关机" ;;
  2) operation="重启" ;;
  3) operation="睡眠" ;;
  4) operation="休眠" ;;
  5) operation="注销" ;;
  *) echo "无效操作"; exit 1 ;;
esac

# 倒计时功能
while [ $total_seconds -gt 0 ]; do
  hours=$((total_seconds / 3600))
  minutes=$(( (total_seconds % 3600) / 60 ))
  seconds=$((total_seconds % 60))
  echo "剩余时间: $hours 小时 $minutes 分钟 $seconds 秒"
  sleep 1
  total_seconds=$((total_seconds - 1))
done

# 获取结束时间
end_time=$(date +"%Y-%m-%d %H:%M:%S")

# 倒计时时间
countdown_time=$(printf "%02d:%02d:%02d" $hour $minute $second)

# 执行对应的操作
case $action in
  0)
    # 显示通知
    echo "倒计时结束, 开始时间: $start_time, 结束时间: $end_time, 倒计时时间: $countdown_time"
    notify-send "倒计时结束" "开始时间: $start_time, 结束时间: $end_time, 倒计时时间: $countdown_time"
    ;;
  1)
    # 关机
    echo "倒计时结束，系统将关机..."
    shutdown -h now "操作: $operation, 开始时间: $start_time, 结束时间: $end_time, 倒计时时间: $countdown_time"
    ;;
  2)
    # 重启
    echo "倒计时结束，系统将重启..."
    shutdown -r now "操作: $operation, 开始时间: $start_time, 结束时间: $end_time, 倒计时时间: $countdown_time"
    ;;
  3)
    # 睡眠
    echo "倒计时结束，系统将进入睡眠模式..."
    systemctl suspend
    ;;
  4)
    # 休眠
    echo "倒计时结束，系统将进入休眠模式..."
    systemctl hibernate
    ;;
  5)
    # 注销
    echo "倒计时结束，系统将注销..."
    pkill -KILL -u "$USER"
    ;;
esac
