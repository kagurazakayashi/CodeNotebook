/bin/kill -15 $(ps -ef|grep ffmpeg|grep -v grep|awk '{print $2}')
