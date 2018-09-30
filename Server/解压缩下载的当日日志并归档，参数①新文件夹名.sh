#!/bin/bash
for i in `ls *.gz`
do
    7za x "$i"
    rm -f "$i"
done
mkdir $1
for j in `ls -1 -F | grep -v [/$]`
do
    mv "$j" "$1/$j.log"
done
