#!/bin/bash

cat file(待读取的文件) | while read line
do
    echo$line
done