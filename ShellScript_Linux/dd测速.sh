# dd测速

# 使用dd指令，对磁盘进行连续写入，不使用内存缓冲区。
# 写入 4k x 500000 的数据 /1000 /1000 = 产生 2.0G (1.9GB)(2,048,000,000 字节) 大小的文件。
dd if=/dev/zero of=./test.tmp bs=4k count=500000 conv=fdatasync
# 读测试
dd if=./test.tmp of=/dev/null bs=4k

# 写入 1000k x 1000 的数据 /1000 /1000 = 产生 1.0G (976MB)(1,024,000,000 字节) 大小的文件。
dd if=/dev/zero of=./test.tmp bs=1000k count=1000 conv=fdatasync
# 读测试
dd if=./test.tmp of=/dev/null bs=1000k

# conv=fdatasync 不走写缓存，表示只把文件的“数据”写入磁盘，dd命令执行到最后会真正执行一次“同步(sync)”操作

# https://www.ttlsa.com/linux/use-dd/
