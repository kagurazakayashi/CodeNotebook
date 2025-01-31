# 从整台电脑中搜索一个字符串
# 在 Linux 中，你可以使用 grep 命令来搜索文件中是否包含特定的字符串。要在整台电脑的文件中搜索一个字符串，可以使用以下命令：
# grep -r "字符串" / --exclude-dir={/proc,/sys,/dev,/run}
# sudo：因为需要访问系统文件，使用 sudo 来获取足够的权限。
# grep -r：递归搜索。
# "字符串"：你要搜索的字符串（请替换为你需要查找的内容）。
# /：表示从根目录开始搜索，意味着会搜索整个文件系统。
# --exclude-dir={/proc,/sys,/dev,/run}：排除一些不需要搜索的目录，避免查找系统虚拟文件系统中的内容。这些目录通常包含大量无关的文件。

# 如果你只想搜索某个特定目录下的文件，可以将 / 替换为目标目录的路径，例如
grep -r "字符串" /home/username/

# 如果想让 grep 显示匹配的行号，可以使用 -n 参数：
sudo grep -rn "字符串" /

# 仅查找小于 1MB 的文件
sudo find / -type f -size -1M \( -path /proc -o -path /sys -o -path /dev -o -path /run \) -prune -o -exec grep -Hn "字符串" {} \;
# -path /proc -o -path /sys -o -path /dev -o -path /run：这些是我们希望排除的目录路径，-o 是逻辑“或”运算符。
# -prune：表示“跳过”这些路径，不进一步进入这些目录。
# -exec grep -Hn "字符串" {} \;：对于其他文件，执行 grep 来搜索指定的字符串。
