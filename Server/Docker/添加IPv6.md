# Docker 添加 IPv6 雅詩记录

## 查看主机网络

`ip -6 addr`

```txt
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 state UNKNOWN qlen 1000
    inet6 ::1/128 scope host noprefixroute
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 state UP qlen 1000
    inet6 2403:fbd0:2000::64e9:cfb6/48 scope global <-- 取主机 v6 子网
       valid_lft forever preferred_lft forever
    inet6 fe80::216:3cff:fef9:9c92/64 scope link
       valid_lft forever preferred_lft forever
```

## 从主机网络划分子网

- 主机网络: `2403:fbd0:2000::64e9:cfb6/48`
- 第一子网: `2403:fbd0:2000:0000::/64` -> 给 Docker bridge 主网
- 第二子网: `2403:fbd0:2000:0001::/64` -> 给自己的 work 网络
- 第三子网: `2403:fbd0:2000:0002::/64`
- 第四子网: `2403:fbd0:2000:0003::/64`
- ...

## Docker bridge 主网

`vim /etc/docker/daemon.json`

```json
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "500m",
    "max-file": "4"
  },
  "features": {
    "buildkit": true
  },
  "ipv6": true, // +
  "fixed-cidr-v6": "2403:fbd0:2000:0000::/64", // +
  "experimental": true, // +
  "ip6tables": true // +
}
```

## work 的子网

- `172.18.0.0/16`
- `2403:fbd0:2000:0001::/64`

## 删除旧的 work 网络

- 看看网络列表: `docker network inspect work`
- 看看哪些容器连着这个网络: `docker network inspect work`
- 停止这些容器: `docker stop 容器名`
- 删除旧的 work 网络: `docker network rm work`

## 创建新的 work 网络

`docker network create --driver bridge --subnet=172.18.0.0/16 --ipv6 --subnet=2403:fbd0:2000:0001::/64 work`

将容器连接到新网络: `docker network connect work 容器名`

## ip6tables 更新转发

- 查看当前规则: `ip6tables -L -v -n`
  - 添加转发: `ip6tables -A FORWARD -i docker0 -o eth0 -j ACCEPT`
  - 添加转发: `ip6tables -A FORWARD -i eth0 -o docker0 -j ACCEPT`

```txt
# ip6tables -L -v -n

Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination         

Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination         
    0     0 ACCEPT     0    --  docker0 eth0    ::/0                 ::/0                
    0     0 ACCEPT     0    --  eth0   docker0  ::/0                 ::/0                

Chain OUTPUT (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination
```

## 运行一个临时容器看看里面有没有网

- `docker run --rm -it --network work alpine sh`
  - `ip -6 addr`
  - `ping6 ipv6.google.com`

## 测试内部 v6 地址 `fd00:` 也可以访问外网

```bash
docker network create --driver bridge --ipv6 --subnet=fd00:fbd0:2000:0001::/64 v6test
docker run --rm -it --network v6test alpine sh
ping6 ipv6.google.com
```

## 官方文档参考

[Use IPv6 networking](https://docs.docker.com/engine/daemon/ipv6/)
