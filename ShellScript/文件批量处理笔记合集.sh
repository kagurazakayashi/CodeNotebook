# 文件批量处理

# 删除 AAA_ 开头的所有文件
find /path/to/directory -type f -name "AAA_*" -exec rm -f {} +

# 浏览所有 tar 中的文件
find /path/to/directory -type f -name "*.tar" -exec tar -tf {} \;

# 遍历处理文件时不包含 ./
find ./ -type f -name "*.tar" | sed 's|^\./||' | while read -r tar_file; do

# 将文件夹 A 复制到文件夹 B ，包含子文件夹，但只复制 .jpg 文件。
find A -type f -name "*.jpg" -exec bash -c 'mkdir -p "B/$(dirname "{}" | sed "s|^A/||")"; cp "{}" "B/$(dirname "{}" | sed "s|^A/||")/"' \;

# 将当前文件夹中所有文件名中的 AAA 替换为 BBB
rename 's/AAA/BBB/' *
# 也包含子文件夹
find . -type f -name '*AAA*' -exec rename 's/AAA/BBB/' {} +

# 搜索当前目录及其子目录，找出所有文件，从小到大排序
find . -type f -exec ls -lh {} + | awk '{ print $5, $9 }' | sort -h
# 不需要人类可读格式
find . -type f -printf "%s %p\n" | sort -n

# 找到当前文件夹和子文件夹下所有 tar 文件并 xz 压缩它们
find . -type f -name "*.tar" -exec xz -v {} \;
find . -type f -name "*.tar" -exec nice -n 19 xz -z -9 -e --lzma2 --block-size=512M --threads=8 --memlimit=15G --verbose {} \;

# 检查 ssh-add -l 的输出是否包含 Error connecting to agent
if ssh-add -l 2>&1 | grep -q "Error connecting to agent"; then fi

# 通过 ssh （证书验证）将本地的 /aaa/bbb.txt 复制到另一个 linux 服务器上的 /ccc/ddd.txt
scp -i ~/.ssh/id_rsa /aaa/bbb.txt user@remote_server:/ccc/ddd.txt
