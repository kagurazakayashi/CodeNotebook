#!/bin/bash
# 雅诗 M3U8 下载工具脚本 2.0
# 将 m3u8 连带其中所有的 ts 视频下载到指定文件夹。有临时文件夹支持。
# "m3u8.sh" http://video.xxx.com/e539eb16940b4556bfcc8e27786af251/689e8d166816499ea4cace40ffae4b11-adce3b762a1455b487497f31ccd63e79-od-S00000001-100000.m3u8
# by 神楽坂雅詩
tempdir="/Volumes/RamDisk/"
tempmax=500
OLD_IFS="$IFS"
IFS="?"
b=($1)
purl=${b[0]}
IFS="/"
a=($purl)
IFS="$OLD_IFS"
fname=${a[${#a[@]}-1]}
valarr=0
vals=${b[1]}
for i in ${valarr[${#valarr[@]}]};do
    vals=$vals/$i;
done
unset "a[${#a[@]}-1]"
pstr=${a[0]}
referer=${a[2]}
unset "a[0]"
str=""
for i in ${a[@]};do
    str=$str/$i;
done
furl="$pstr/$str/"
# 自定义 referer
# referer=""
echo "===================="
echo "[雅诗 M3U8 下载工具脚本]"
echo "2.0"
echo "[相对网址]"
echo $furl
echo "[播放列表文件名]"
echo $fname
echo "[网络协议]"
echo $pstr
echo "[提交参数]"
echo $vals
echo "[引用位置参数]"
echo $referer
echo "[完整路径]"
echo $1
echo "--------------------"
echo "[开始下载播放列表]"
curl -e "$referer" "$1" -o "${tempdir}list.m3u8"
openssl md5 "${tempdir}list.m3u8" -o "${tempdir}list.md5"
cat "${tempdir}list.m3u8"
echo "[解析播放列表]"
k=0
while read line
do
    if [[ $line != \#* ]] && [[ $line == *.ts ]]; then
        k=`expr $k + 1`
        echo $k
    fi
done < "${tempdir}list.m3u8"
i=0
j=0
while read line
do
    if [[ $line != \#* ]] && [[ $line == *.ts ]]; then
        i=`expr $i + 1`;
        j=`expr $j + 1`;
        echo "[文件$j/$k][缓存区$i/$tempmax] $furl$line"
        curl -e "$referer" "$furl$line" -o "$tempdir$line"
        openssl md5 "$tempdir$line" >> "${tempdir}list.md5"
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
done < "${tempdir}list.m3u8"
ls $tempdir*.ts > "${tempdir}tslist.txt"
while read line
do
    i=`expr $i - 1`;
    echo "[存储文件][缓存区$i/$tempmax] $line"
    mv "$line" ./
done < "${tempdir}tslist.txt"
rm -f "${tempdir}tslist.txt"
mv "${tempdir}list.md5" ./
mv "${tempdir}list.m3u8" ./
echo "[下载完成]"
ls -hl
echo "===================="