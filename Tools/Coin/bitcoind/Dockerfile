FROM debian:latest
WORKDIR /root
COPY ./bitcoin-25.0-x86_64-linux-gnu.tar.gz ./bitcoin.gz
RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list.d/debian.sources
RUN apt update && apt upgrade -y && apt install tar gzip -y
RUN tar -zxvf bitcoin.gz && mv bitcoin-25.0 bitcoin
RUN chmod +x /root/bitcoin/bin/*
ENTRYPOINT ["/root/bitcoin/bin/bitcoind", "-datadir=/root/BitcoinData", "-dbcache=256", "-debuglogfile=/root/BitcoinData/bitcoind.log", "-par=1", "-prune=1024", "-rpcbind=0.0.0.0", "-rpcport=8332", "-rpcuser=yashi", "-rpcpassword=N6qbZnGWo7pnLas4", "-server"]