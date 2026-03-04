# 转换插补帧的GIF，将每帧变为全尺寸的完整帧
convert 1.gif -coalesce -set dispose previous 2.gif
# 将全尺寸完整帧GIF，压缩为插帧
convert 2.gif -layers Optimize 1.gif
# 拆分GIF
convert 1.gif 1.png
convert -strip 1.gif 1.png # 重新渲染

# 批量调整 GIF 尺寸
for file in *.gif; do convert $file -coalesce -set dispose previous $file; convert -resize 512x512 $file $file; convert $file -layers Optimize $file; done