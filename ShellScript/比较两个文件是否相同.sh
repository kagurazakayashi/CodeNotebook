#!/bin/bash
# ScriptName: file_diff.sh
echo "usage: -$0 file1 file2"
file1=$1
file2=$2
if [ -f $file1 ] && [ -f $file2 ]
then
    diff $file1 $file2 > /dev/null
    if [ $? != 0 ]
    then
        echo "Different!"
    else
        echo "Same!"
    fi
else
    echo "$file1 or $file2 does not exist, please check filename."
fi
