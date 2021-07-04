df
# 文件系统               1K-块        已用     可用 已用% 挂载点
# /dev/mapper/VolGroup00-LogVol00
#                       26472316   5887296  19218596  24% /
# /dev/hda1               101086     12985     82882  14% /boot
# tmpfs                  2025372         0   2025372   0% /dev/shm

# 显示易读文件大小等信息
df -h
# 文件系统              容量  已用 可用 已用% 挂载点
# /dev/mapper/VolGroup00-LogVol00
#                        26G  5.7G   19G  24% /
# /dev/hda1              99M   13M   81M  14% /boot
# tmpfs                 2.0G     0  2.0G   0% /dev/shm


# df [参数]
# -a, --all 包含所有的具有 0 Blocks 的文件系统
# --block-size={SIZE} 使用 {SIZE} 大小的 Blocks
# -h, --human-readable 使用人类可读的格式(预设值是不加这个选项的...)
# -H, --si 很像 -h, 但是用 1000 为单位而不是用 1024
# -i, --inodes 列出 inode 资讯，不列出已使用 block
# -k, --kilobytes 就像是 --block-size=1024
# -l, --local 限制列出的文件结构
# -m, --megabytes 就像 --block-size=1048576
# --no-sync 取得资讯前不 sync (预设值)
# -P, --portability 使用 POSIX 输出格式
# --sync 在取得资讯前 sync
# -t, --type=TYPE 限制列出文件系统的 TYPE
# -T, --print-type 显示文件系统的形式
# -x, --exclude-type=TYPE 限制列出文件系统不要显示 TYPE
# -v (忽略)
# --help 显示这个帮手并且离开
# --version 输出版本资讯并且离开

df
# Filesystem    512-blocks       Used Available Capacity iused      ifree %iused  Mounted on
# /dev/disk2s1  1953491968 1870208000  83283968    96% 3652750     162664   96%   /Volumes/udisk

# 文件系统          1K-块     已用     可用 已用% 挂载点
# /dev/sdc1      33537028 12128940 21408088   37% /

# 第一列指定文件系统的名称，第二列指定一个特定的文件系统1K-块1K是1024字节为单位的总内存。用和可用列正在使用中，分别指定的内存量。

df -h
# 文件系统        容量  已用  可用 已用% 挂载点
# /dev/sdc1        32G   12G   21G   37% /

# https://www.runoob.com/linux/linux-comm-df.html