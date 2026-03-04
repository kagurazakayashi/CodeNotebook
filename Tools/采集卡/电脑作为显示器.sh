# 电脑作为显示器显示采集卡内容

# 列出所有设备
ls /dev/video*
# 显示单个设备支持格式
v4l2-ctl --list-formats-ext --get-fmt-video --device=/dev/video2
ffmpeg -f v4l2 -list_formats all -i /dev/video2
# 配置格式
v4l2-ctl --device=/dev/video2 --set-fmt-video=width=1920,height=1080,pixelformat=YUYV
# 配置帧率
v4l2-ctl --device=/dev/video2 --set-parm=60

# ffplay 最低延迟、无声、全屏
ffplay -fs \
  -an \
  -fflags nobuffer \
  -fflags flush_packets \
  -flags low_delay \
  -framedrop \
  -sync ext \
  -f v4l2 \
  -input_format mjpeg \
  -video_size 1920x1080 \
  -framerate 30 \
  -i /dev/video2

# mpv 最低延迟、无声、全屏
mpv /dev/video2 \
  --fullscreen \
  --no-audio \
  --no-cache \
  --untimed \
  --vd-lavc-threads=1 \
  --profile=low-latency \
  --video-sync=display-resample \
  --demuxer=lavf \
  --demuxer-lavf-o-add=video_size=1920x1080 \
  --demuxer-lavf-o-add=framerate=50 \
  --demuxer-lavf-o-add=pixel_format=mjpeg


# 在 xterm 中以高优先级运行

# vim ~/playscreen-xterm.sh
xterm -hold -e sh -c '$HOME/playscreen-x.sh'

# vim ~/playscreen-x.sh
xhost +SI:localuser:root; sudo --preserve-env=DISPLAY,XAUTHORITY XAUTHORITY=$HOME/.Xauthority $HOME/playscreen.sh; xhost -SI:localuser:root

# vim ~/playscreen.sh
#!/bin/bash
VIDEODEV=$(
  for dev in /dev/video*; do
    props=$(/usr/bin/udevadm info --query=property --name="$dev")
    if echo "$props" | /usr/bin/grep -q "ID_MODEL=UGREEN_25854"; then
      echo "$dev"
    fi
  done | /usr/bin/head -n 1
)
echo "VIDEODEV=$VIDEODEV"
/usr/bin/nice -n -9 /usr/bin/ffplay \
-fs -an \
-fflags nobuffer \
-fflags flush_packets \
-flags low_delay \
-framedrop \
-sync ext \
-f v4l2 \
-input_format mjpeg \
-video_size 1920x1080 \
-framerate 30 \
-i $VIDEODEV

# -vf "eq=saturation=0.8"  #修正：颜色太艳降低饱和度
# xrandr --output eDP-1 --gamma 1.5:1.5:1.5  #修正：xorg登录桌面的话可以改gamma值降低饱和度

# 非压缩 -input_format yuyv
