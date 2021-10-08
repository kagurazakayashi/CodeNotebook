#!/bin/bash
touch /Volumes/RAMDISK/opencctemp.txt
chmod 777 /Volumes/RAMDISK/opencctemp.txt
read str
echo $str > /Volumes/RAMDISK/opencctemp.txt
echo '->'
str=`opencc -i /Volumes/RAMDISK/opencctemp.txt -c s2twp.json`
echo $str
echo $str | xargs echo -n | pbcopy
unset str
rm -f /Volumes/RAMDISK/opencctemp.txt