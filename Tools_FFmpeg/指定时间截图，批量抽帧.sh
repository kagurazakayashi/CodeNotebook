# 指定时间截图
ffmpeg -i a.mp4 -y -f image2 -ss 00:01:00 -vframes 1 a.jpg

# 抽帧
ffmpeg -i output_000.mp4 -vf fps=fps=8 -f image2 ./%05d.jpg
