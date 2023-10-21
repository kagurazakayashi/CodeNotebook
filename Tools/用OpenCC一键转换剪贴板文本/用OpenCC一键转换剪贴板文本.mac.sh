#!/bin/bash
openccBuildPath=opencc
tempFilePath=/Volumes/RAMDISK
touch $tempFilePath/opencctemp.txt
chmod 777 $tempFilePath/opencctemp.txt
read str
echo $str > $tempFilePath/opencctemp.txt
echo '->'
str=`$openccBuildPath --input $tempFilePath/opencctemp.txt --config $openccBuildPath/share/opencc/s2twp.json`
echo $str
echo $str | xargs echo -n | pbcopy
rm -f $tempFilePath/opencctemp.txt
unset str
unset tempFilePath
unset openccBuildPath
