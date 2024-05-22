# 查找最大文件夹 文件夹大小排名
# 统计/最大的文件或者文件夹（不会进入子文件夹）前 25 名：
du -a / 2>/dev/null | sort -n -r | head -n 25
# du   : 计算出单个文件或者文件夹的磁盘空间占用.
# sort : 对文件行或者标准输出行记录排序后输出.
# head : 输出文件内容的前面部分.

# 导出并压缩
du -a / 2>/dev/null | sort -n -r | xz -z -e -9 -T 0 -v -c >du_sort_`date +%Y-%m-%d-%H-%M-%S-%s`.log.xz

# 输出可读性高的内容：
# 先进入要统计的文件夹：
cd /path/to/some/where
# 统计当前目录最大的文件或者文件夹（不会进入子文件夹）
du -hsx * | sort -rh | head -25
# 找出最大文件夹再进阶 cd ...
