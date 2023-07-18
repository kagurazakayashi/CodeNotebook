#!/bin/bash
docker volume create v_v2
cp ./privoxy.config /var/lib/docker/volumes/v_v2/_data/privoxy.config
cp -rf privoxy /var/lib/docker/volumes/v_v2/_data/
docker stop v2_c
docker rm v2_c
docker rmi v2_i
docker build -t v2_i .
docker run -it -p 22222:22222 --name v2_c --net work --ip 172.18.0.223 -v v_v2:/root/conf -d v2_i

# curl --socks5 127.0.0.1:23332 -I https://www.google.com
# curl -x 127.0.0.1:22222 -I https://www.google.com