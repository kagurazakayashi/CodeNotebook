# 旋转视频

# 0-逆时针旋转90度，垂直翻转。这也是默认设置。
# 1-顺时针旋转90度。
# 2-逆时针旋转90度。
# 3-顺时针旋转90度，垂直翻转。
ffmpeg -i input.mp4 -vf "transpose=1" output.mp4

# 要将视频顺时针旋转180度，需要像下面这样转置两次。
ffmpeg -i input.mp4 -vf "transpose=2,transpose=2" output.mp4

# 仅仅更改元数据中的旋转设置，就用以下的命令：
ffmpeg -i input.mp4 -c copy -metadata:s:v:0 rotate=90 output.mp4

# 你可以将输入文件的所有全局元数据，复制到输出文件中，包括日期、摄像机详细信息等。如下所示：
ffmpeg -i input.mp4 -map_metadata 0 -metadata:s:v rotate="90" -codec copy output.mp4

# https://cloud.tencent.com/developer/article/1638406