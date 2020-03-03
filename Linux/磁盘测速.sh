hdparm -Tt /dev/sda

# dd 测试

# 测试磁盘的IO写速度
time dd if=/dev/zero of=test.dbf bs=8k count=3000000
# 如果要测试实际速度 还要在末尾加上 oflag=direct测到的才是真实的IO速度

# 测试磁盘的IO读速度
dd if=test.dbf bs=8k count=3000000 of=/dev/null

rm test.dbf