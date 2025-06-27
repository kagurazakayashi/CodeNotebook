# 创建随机内容文件

# Windows 可以用 Git Bash / MSYS2，/dev/urandom 提供伪随机内容，和 Linux 上的行为一致。
dd if=/dev/urandom of=/c/path/to/random_1gb_file.bin bs=1M count=1024

# dd	用于按块复制和转换数据的工具
# if=/dev/urandom	输入文件（input file）：使用 Linux 提供的伪随机数设备 /dev/urandom 作为数据来源
# of=/c/path/to/random_1gb_file.bin	输出文件（output file）：生成的随机数据将被写入这里
# bs=1M	块大小（block size）：每次读取和写入 1MB（= 1024 × 1024 字节）
# count=1024	总共写入 1024 个块，每个块 1MB，总共是 1024MB = 1GB
