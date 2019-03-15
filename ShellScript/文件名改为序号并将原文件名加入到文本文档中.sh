#!/bin/bash
i=0;
for f in *.jpg
do
    echo $f >> filelist.txt
    mv "${f}" "${i}.jpg"
    i=`expr $i + 1`;
done