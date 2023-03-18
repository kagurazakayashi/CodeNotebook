#!/bin/bash
# 收集所有指定文件，以哈希为文件名防止重名覆盖
f_dir="/"
f_srh="*.icns"
t_dir="/Volumes/KYS1TX2/icns"
t_ext=".icns"
# for f in `find` 处理带空格文件名会有问题 # while 代替 for find
while IFS= read -r -d '' f; do
    # cut 取空格前部分哈希 # tr 转大写
    to_f="$t_dir/`openssl gost-mac -r "$f" | cut -d " " -f 1 | tr a-z A-Z`$t_ext"
    cp -f -v "$f" "$to_f"
done < <(find -P "$f_dir" -type f -iname "$f_srh" -not -path "$t_dir" -print0 2>/dev/null)
