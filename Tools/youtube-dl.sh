# install youtube-dl
# install youtube-dlg/youtube-dl-gui

# 最简单的方式就是直接加上视频链接地址就可以自动下载到当前文件夹：
youtube-dl <url>
# 使用代理
youtube-dl <url> --proxy http://127.0.0.1:1080
# 下载列表
youtube-dl --yes-playlist https://www.youtube.com/playlist?list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG --proxy http://127.0.0.1:1080
# 下载字幕
youtube-dl.exe --yes-playlist https://www.youtube.com/playlist?list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG --proxy http://127.0.0.1:1080 --write-auto-sub --sub-lang zh-Hans,zh-Hant
# 下载列表和字幕
youtube-dl https://www.youtube.com/playlist?list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG --write-auto-sub --sub-lang zh-Hans
# --write-sub 写字幕文件
# --write-auto-sub 写自动生成的字幕文件 (YouTube only)
# --all-subs 下载所有可提供的字幕
# --list-subs 列出当前视频支持的所有字幕
# --sub-format FORMAT 指定字幕格式，比如 "srt" 或者 "ass/srt/best"
# --sub-lang LANGS 指定字幕语言，用`,`分隔

# 获得指定链接中的视频格式
youtube-dl --no-check-certificate --proxy=127.0.0.1:23333 --list-formats 【url】
# 按format code下载指定的质量的视频，按format code下载指定的质量的音频。
youtube-dl --no-check-certificate --proxy=127.0.0.1:23333 -f 【format code】 【url】 
# 使用 ffmpeg 合并影视频文件
ffmpeg -i 【不带音频的视频文件.mp4】 -i 【音频文件.m4a】 -c:v copy -c:a copy 【音视频合成后的文件.mp4】