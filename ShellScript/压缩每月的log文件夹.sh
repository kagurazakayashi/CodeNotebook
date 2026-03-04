#!/bin/bash
cd /var/log/sys

# 获取当前系统的年月 (YYYY-MM)
current_month=$(date +"%Y-%m")

# 获取当前文件夹中所有符合日期格式的文件
files=$(ls | grep -E '^[0-9]{4}-[0-9]{2}-[0-9]{2}$')

# 使用数组存储需要归档的文件
declare -A month_files

# 遍历文件，将它们按月份分类
for file in $files; do
    month=${file:0:7} # 提取 YYYY-MM
    if [[ "$month" != "$current_month" ]]; then
        month_files[$month]="${month_files[$month]} $file"
    else
        echo "跳过当前月份文件: $file"
    fi
done

# 归档并压缩
for month in "${!month_files[@]}"; do
    tar -cv ${month_files[$month]} | nice -n 19 xz -z -9 -e -T 0 -v >"${month}.tar.xz"
    echo "已创建压缩包: ${month}.tar.xz"
    rm -rv ${month_files[$month]}
done

echo "打包完成，当前月份 ($current_month) 的文件未被压缩。"
