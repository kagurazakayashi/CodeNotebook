# 删除文件
rm 1.txt    # 单个文件
rm *.txt    # 多个文件
rm -f 1.txt # 强制删除
rm -r dir   # 递归删除/删除整个目录
rm -rf dir  # 强制删除目录，不要挨个提示
rm -i 1.txt # 挨个提示每个文件是否要删除

# 【小心】防止 rm -rf /
# rm -rf / root/temp