# 将video.avi 中的视频提取到临时文件video2.avi中
ffmpeg -i video.avi -vcodec copy -an video2.avi

# 合并 video2.avi 和  audio.mp3 到output.avi
ffmpeg -i video2.avi -i audio.mp3 -vcodec copy -acodec copy output.avi
