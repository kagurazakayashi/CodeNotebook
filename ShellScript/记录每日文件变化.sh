#!/bin/bash
logdir=/var/log/sys
tmpdir=/var/log/diskdiff

# 获取当前日期
current_date=$(date +%Y-%m-%d)

# 收集所有文件和目录的完整路径到 b.log
find / -path /proc -prune -o -type f -o -type d -print 2>/dev/null >"${tmpdir}/b.log"

# 检查 a.log 和 b.log 的区别
if [ -f a.log ]; then
    diff "${tmpdir}/a.log" "${tmpdir}/b.log" > "${logdir}/${current_date}.log"
fi

# 删除 a.log 并将 b.log 重命名为 a.log
rm -f "${tmpdir}/a.log"
mv "${tmpdir}/b.log" "${tmpdir}/a.log"
