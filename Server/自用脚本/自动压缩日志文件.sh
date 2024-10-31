#!/bin/bash
cd "/var/log/sys"

# 获取上个月的年份和月份
YEAR=$(date -d "last month" +%Y)
MONTH=$(date -d "last month" +%m)
TO_DIR="/mnt/d/syslog"
OUTPUT_FILE="$TO_DIR/$YEAR$MONTH.7z"
LOG_FILE="$TO_DIR/$YEAR$MONTH.log"
SRC_FILE="$YEAR-$MONTH-*"
date > "$LOG_FILE"

# 使用 7z 压缩上个月的日志文件
nice -n 19 7za a "$OUTPUT_FILE" "$SRC_FILE" >> "$LOG_FILE" 2>&1

# 检查压缩是否成功
if [ $? -eq 0 ]; then
    # 删除原始日志文件
    rm -rf "$(pwd)/$SRC_FILE"
    echo "将 $(pwd)/$SRC_FILE 压缩到 $OUTPUT_FILE 成功。" >> "$LOG_FILE"
else
    echo "将 $(pwd)/$SRC_FILE 压缩到 $OUTPUT_FILE 失败！" >> "$LOG_FILE"
fi
date >> "$LOG_FILE"

# 删除脚本中创建的所有变量
unset YEAR MONTH TO_DIR OUTPUT_FILE LOG_FILE SRC_FILE

# 每月1日 0点0分 执行
# 0 0 1 * * /bin/bash /mnt/d/server/timerjob/zipsyslog.sh
