FROM alpine:latest
WORKDIR /root
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN apk add --no-cache privoxy curl
COPY ./v2ray-linux-64.zip ./v2ray-linux-64.zip
COPY ./run.sh ./run.sh
RUN unzip v2ray-linux-64.zip
RUN rm -f v2ray-linux-64.zip
RUN chmod +x run.sh v2ray /usr/sbin/privoxy
HEALTHCHECK --interval=600s CMD curl -x 127.0.0.1:22222 --fail "http://www.google.com" || exit 1  
ENTRYPOINT ./run.sh
