#!/bin/bash
# 先 cd 到 GIF 副本目录
mkdir ./GIF-PNG
mkdir ./GIF-PNG-512Z
mkdir ./GIF-512Z
mkdir ./GIF
for f in *.gif
do
    echo $f
    # 备份源文件
    cp $f ./GIF/$f
    # 转换插补帧的GIF，将每帧变为全尺寸的完整帧
    convert $f -coalesce -set dispose previous $f
    # 拆分GIF，重新渲染 为PNG
    mkdir ./GIF-PNG/${f%%.*}
    convert -strip $f ./GIF-PNG/${f%%.*}/${f%%.*}.png
    # 调整 PNG 大小
    mkdir ./GIF-PNG-512Z/${f%%.*}
    convert -strip $f -resize 512x512 ./GIF-PNG-512Z/${f%%.*}/${f%%.*}.png
    # 调整 GIF 尺寸
    convert $f -resize 512x512 ./GIF-512Z/$f
    # 将全尺寸完整帧GIF，压缩为插帧
    convert ./GIF-512Z/$f -layers Optimize ./GIF-512Z/$f
    # 移除该临时文件
    rm $f
done