# mp4转码m3u8

# 如果视频不为mp4格式，需先将视频转码为mp4，可使用如下命令进行转换
ffmpeg -i 本地视频地址 -y -c:v libx264 -strict -2 转换视频.mp4

# 将mp4格式转换为ts格式
ffmpeg -y -i 本地视频.mp4 -vcodec copy -acodec copy -vbsf h264_mp4toannexb 转换视频.ts

# 将ts文件进行切片
ffmpeg -i 本地视频.ts -c copy -map 0 -f segment -segment_list 视频索引.m3u8 -segment_time 10 前缀-%03d.ts
# 其中segment 就是切片，-segment_time表示隔几秒进行切一个文件，上面命令是隔5s，你也可以调整成更大的参数。