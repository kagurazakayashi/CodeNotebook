#!/bin/bash
# 将 m3u8 连带其中所有的 ts 视频下载到指定文件夹。有临时文件夹支持。
# "m3u8.sh" http://video.xxx.com/e539eb16940b4556bfcc8e27786af251/ 689e8d166816499ea4cace40ffae4b11-adce3b762a1455b487497f31ccd63e79-od-S00000001-100000.m3u8
# 注意中间网址加了一个空格
# by 神楽坂雅詩
tempdir="/Volumes/RamDisk/"
tempmax=500
referer="http://www"
echo "$1$2"
curl -e "$referer" "$1$2" -o "$tempdir$2"
md5sum "$tempdir$2" > "$tempdir$2.md5"
cat "$tempdir$2"
i=0
cat "$tempdir$2" | while read line
do
    if [[ $line != \#* ]] && [[ $line == *.ts ]]; then
        i=`expr $i + 1`;
        echo "[$i] $1$line"
        curl -e "$referer" "$1$line" -o "$tempdir$line"
        md5sum "$tempdir$line" >> "$tempdir$2.md5"
        if [ $i -gt $tempmax ]; then
            for f in `ls $tempdir*.ts`
            do
                i=`expr $i - 1`;
                echo "[$i] $f"
                mv "$f" ./
            done
            i=0;
        fi
    fi
done
for f in `ls $tempdir*.ts`
do
    i=`expr $i - 1`;
    echo "[$i] $f"
    mv "$f" ./
done
mv "$tempdir$2.md5" ./
mv "$tempdir$2" ./
ls -hl