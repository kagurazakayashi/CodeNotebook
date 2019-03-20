#!/bin/bash
i=0
for f in `find ./ -name "*.ts"`
do
    i=`expr $i + 1`;
done
echo $i