#!/bin/bash
# 压缩每月的文件

# 定义日志文件所在的目录
LOG_DIR="."  # 你可以根据需要修改这个目录

# 获取当前的年-月
current_year_month=$(date +%Y-%m)

# 获取所有的日志文件
for log_file in "$LOG_DIR"/*.log; do
  # 获取日志文件的年份和月份
  year_month=$(basename "$log_file" | cut -d'-' -f1,2)

  # 如果是当前月份，跳过该文件
  if [ "$year_month" == "$current_year_month" ]; then
    echo "当前月份 ${current_year_month} 的日志文件，跳过..."
    continue
  fi

  # 创建一个每月的目录
  month_archive="${year_month}.7z"

  # 检查该月份的 7z 文件是否已经存在，若不存在，则打包
  if [ ! -f "$month_archive" ]; then
    echo "正在打包 ${year_month} 的日志文件..."
    # 找到该月份的所有日志文件，并将它们打包成一个 7z 文件
	echo "$month_archive -> $LOG_DIR"/*${year_month}*.log
    nice -n 19 7z a -mx9 -sdel "$month_archive" "$LOG_DIR"/*${year_month}*.log
  else
    echo "${year_month} 的打包文件已存在，跳过..."
  fi
done

echo "日志文件打包完成！"
