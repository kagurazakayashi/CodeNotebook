# https://hub.docker.com/r/cturra/ntp
docker pull cturra/ntp
docker run --name=ntp --net work --ip 172.18.0.123 --detach --publish=123:123/udp --restart=always --env=NTP_SERVERS="ntp.ntsc.ac.cn,ntp4.aliyun.com,ntp1.aliyun.com,time.nist.gov,time.asia.apple.com,time.windows.com" cturra/ntp