#!/bin/bash
OLD_IFS="$IFS" 
IFS="  "
cat "$1" | while read line
do
    arr=($line)
    fmd5=${arr[0]}
    faddr=${arr[1]}
    md5=`md5sum "${arr[1]}"`
    newarr=($md5)
    md5=${newarr[0]}
    if [ "$fmd5"x = "$md5"x ]; then
        echo -en .
        # echo "$faddr :"
        # echo "[  O K  ] $md5 == $fmd5"
    else
        echo "$faddr :"
        echo "[ ERROR ] $md5 != $fmd5"
    fi
done
IFS="$OLD_IFS"