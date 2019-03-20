# 720P 1000K 压缩
ffmpeg -i "B.MP4" -b:v 1000k -s 1280x720 -acodec copy "B-COMPRESSED.MP4"

# 720P 1000K 合并压缩
ffmpeg -f concat -i filelist.txt -b:v 1000k -s 1280x720 -acodec copy B-COMPRESSED.MP4

# filelist.txt:
file '1.mp4'
file '2.mp4'
file '3.mp4'

# IntelQuickSync
ffmpeg -i "1.mp4" -b:v 1000k -c:v h264_qsv enc_qsv.264 -s 1280x720 -acodec copy "1x.MP4"