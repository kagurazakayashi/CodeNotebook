#!/bin/bash
# 下载数字区间文件到当前脚本所在的内存盘，再移动到硬盘
# sh 批量序号缓存下载文件.sh "sc" "" 0 3 6
# sh 批量序号缓存下载文件.sh "前缀" "后缀" 开始数 结束数 数字固定位数
for((i=$3;i<=$4;i++));
do
wnum=`printf "%0$5d\n" $i`
url=$1$wnum$2
fname=${url##*/}
echo "$i / $4 : $url -> $fname"
curl "$url" -o "$fname"
mv "$fname" "/Volumes/0wew0-1T/vtmp/$fname"
done