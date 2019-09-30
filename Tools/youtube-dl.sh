# install youtube-dl
# install youtube-dlg/youtube-dl-gui

# 获得指定链接中的视频格式
youtube-dl --no-check-certificate --proxy=127.0.0.1:23333 --list-formats 【url】
# 按format code下载指定的质量的视频，按format code下载指定的质量的音频。
youtube-dl --no-check-certificate --proxy=127.0.0.1:23333 -f 【format code】 【url】 
# 使用 ffmpeg 合并影视频文件
ffmpeg -i 【不带音频的视频文件.mp4】 -i 【音频文件.m4a】 -c:v copy -c:a copy 【音视频合成后的文件.mp4】