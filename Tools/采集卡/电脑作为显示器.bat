TITLE 电脑作为显示器显示采集卡内容

ECHO 列出所有设备
ffmpeg -list_devices true -f dshow -i dummy
ECHO 显示单个设备支持格式
ffmpeg -f dshow -list_options true -i video="AVerMedia U3 Video Capture"

ECHO ffplay 最低延迟、无声、全屏
ffplay -fs -an -fflags nobuffer -fflags flush_packets -flags low_delay -framedrop -sync ext -f dshow -pixel_format yuyv422 -video_size 1920x1080 -framerate 60 -i video="AVerMedia U3 Video Capture"

ECHO mpv 最低延迟、无声、全屏
mpv "av://dshow:video=AVerMedia U3 Video Capture" --no-audio --profile=low-latency --no-cache --untimed --vd-lavc-threads=1 --video-sync=display-resample --demuxer=lavf --demuxer-lavf-o-add=video_size=640x480 --demuxer-lavf-o-add=framerate=30 --demuxer-lavf-o-add=pixel_format=yuyv422
