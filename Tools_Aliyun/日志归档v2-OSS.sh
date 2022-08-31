#!/bin/bash
# 將阿里雲轉存到 OSS 的 OSS 日誌歸檔
# 在 OSS 列表資料夾中執行
# 年份前必須先加上 `-` 分隔符！
# by 神楽坂雅詩

# 解壓縮所有 gz 壓縮包
for f in `find . -iname "*.gz"`
do
    echo gzip -d $f
    gzip -d $f
done

# 將所有檔案移動到根目錄
find . -type f -exec mv {} ./ \;

# 所有以 `.` 開頭的檔名改為 `@.`
for f in .*.*
do
    echo mv "$f" "@$f"
    mv "$f" "@$f"
done

# 將每個檔案按照 `年\年-月\域名\域名_年_月_日.log` 進行歸檔
for f in *-*-*-*
do
    farr=$(echo $f | tr "-" "\n")
    ndate=''
    ndir0=''
    ndir1=''
    ndir2=''
    ndir3=''
    i=0
    for nunit in $farr
    do
        if [ "$i" = "0" ];then
            ndate=$ndate${nunit}
            ndir0=${nunit}
        fi
        if [ "$i" = "1" ];then
            ndate=$ndate-${nunit}_
            ndir0=${ndir0}-${nunit}
        fi
        if [ "$i" = "2" ];then
            ndate=$ndate${nunit}_
            ndir1=${nunit}
        fi
        if [ "$i" = "3" ];then
            ndate=$ndate${nunit}_
            ndir2=${nunit}
        fi
        if [ "$i" = "4" ];then
            ndate=$ndate${nunit}
            ndir3=${nunit}
        fi
        i=`expr $i + 1`;
    done
    mkdir -p $ndir1/$ndir1-$ndir2/$ndir0
    echo cat $f $ndir1/$ndir1-$ndir2/$ndir0/$ndate.log
    cat $f >>$ndir1/$ndir1-$ndir2/$ndir0/$ndate.log
    rm -f $f
done
