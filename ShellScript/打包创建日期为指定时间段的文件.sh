# 打包创建日期为指定时间段的文件

#!/bin/bash

# 设置目标日期范围
start_date="2024-03" #含 2024-03-01
end_date="2024-04" #不含 2024-04-01
zdir="journal_files"

# 创建一个临时文件夹来存储找到的文件
mkdir $zdir

# 查找文件并复制到临时文件夹
find . -type f -name "*.journal" -newermt $start_date-01 ! -newermt $end_date-01 -exec mv -v {} $zdir/ \;

# 进入临时文件夹
cd $zdir

# 压缩文件成一个 7z 包
nice -19 7z a -t7z -m0=LZMA2 -mx=9 -md=512m -mfb=256 -ms=64g ../$zdir_$start_date.7z *
cd ..

# 清理临时文件夹
rm -rf $zdir

unset start_date
unset end_date
unset zdir
