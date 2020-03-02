ffmpeg -i ./plutopr.mp4 -vcodec copy -acodec copy -ss 00:00:10 -to 00:00:15 ./cutout1.mp4 -y

# -ss time_off        set the start time offset 设置从视频的哪个时间点开始截取，上文从视频的第10s开始截取
# -to 截到视频的哪个时间点结束。上文到视频的第15s结束。截出的视频共5s.
# 如果用-t 表示截取多长的时间如 上文-to 换位-t则是截取从视频的第10s开始，截取15s时长的视频。即截出来的视频共15s.
 
# 注意的地方是：
#  如果将-ss放在-i ./plutopr.mp4后面则-to的作用就没了，跟-t一样的效果了，变成了截取多长视频。一定要注意-ss的位置。
 
# 参数解析
# -vcodec copy表示使用跟原视频一样的视频编解码器。
# -acodec copy表示使用跟原视频一样的音频编解码器。
 
# -i 表示源视频文件
# -y 表示如果输出文件已存在则覆盖。

# 精准切割（占CPU）
ffmpeg -y -i filename -ss 00:00:10 -t 00:00:15 -codec copy

# 快速切割（占内存）
ffmpeg -y -ss 00:00:10 -t 00:00:15 -I filename -c:v libx264 -perset superfast -c:a copy

# libx264 -perset：
# ultrafast
# superfast
# veryfast
# faster
# fast
# medium – default preset
# slow
# slower
# veryslow
# placebo – ignore this as it is not useful (see FAQ)

# 测试成功，音视频能对上：
ffmpeg -i fk.flv -ss 00:06:05 -to 00:06:38 -c:v libx264 -preset placebo -c:a copy fkk.mp4 -y