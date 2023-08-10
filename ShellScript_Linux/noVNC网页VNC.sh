# 直接运行 noVNC

cd ~
git clone https://github.com/kanaka/noVNC
cd noVNC/utils
git clone https://github.com/novnc/websockify
openssl req -new -x509 -days 36500 -nodes -out self.pem -keyout self.pem
cd ..
./utils/novnc_proxy --vnc 127.0.0.1:5901 //--listen 0.0.0.0:6081
firewall-cmd --zone=public --add-port=6080/tcp --permanent
firewall-cmd --reload


# Docker
# 宿主机网关 172.18.0.1  容器地址 172.18.0.68

# Dockerfile:
FROM python:3.11.4-alpine3.18
WORKDIR /root
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN apk add --no-cache bash curl #git
RUN pip install numpy -i https://mirrors.aliyun.com/pypi/simple some-package
# git clone https://github.com/kanaka/noVNC 改为本地拷贝
# WORKDIR /root/noVNC/utils
# RUN git clone https://github.com/novnc/websockify
# RUN openssl req -new -x509 -days 365 -nodes -out self.pem -keyout self.pem
COPY noVNC ./noVNC
WORKDIR /root/noVNC
#COPY noVNC/vnc.html ./index.html
RUN touch ./index.html
HEALTHCHECK --interval=600s CMD curl -I --fail "http://127.0.0.1:6080" || exit 1  
ENTRYPOINT ./utils/novnc_proxy --vnc 172.18.0.1:5901

# run.sh
#!/bin/bash
docker stop novnc_c
docker rm novnc_c
docker rmi novnc_i
docker build -t novnc_i .
docker run -it -p 6080:6080 --name novnc_c --net work --ip 172.18.0.68 -d novnc_i
