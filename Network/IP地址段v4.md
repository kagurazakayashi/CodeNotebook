# 常用网段

| 网段           | 起始地址    | 结束地址        |
| -------------- | ----------- | --------------- |
| 192.168.1.0/24 | 192.168.1.1 | 192.168.1.254   |
| 192.168.0.0/16 | 192.168.0.1 | 192.168.255.254 |

# IP地址

|  概念   |               特征               |    网络范围     |     默认掩码     |        主机地址范围         |
| ------- | -------------------------------- | --------------- | ---------------- | --------------------------- |
| A类地址 | 第1个8位中的第1位始终为0         |   0 - 127.x.x.x | 255.0.0.0/8      | 1.0.0.0   - 126.255.255.255 |
| B类地址 | 第1个8位中的第1、2位始终为10     | 128 - 191.x.x.x | 255.255.0.0/16   | 128.0.0.0 - 191.255.255.255 |
| C类地址 | 第1个8位中的第1、2、3位始终为110 | 192 - y.x.x.x   | 255.255.255.0/24 | 192.0.0.0 - 223.255.255.255 |
| D类地址 |                                  |                 |                  | 224.0.0.0 - 239.255.255.255 |
| E类地址 |                                  |                 |                  | 224.0.0.0 - 247.255.255.255 |

# IP-CIDR对应子网地址范围

| * | CIDR block     | IP range(network - broadcast) | Subnet Mask     | IPQuantity |
| - | -------------- | ----------------------------- | --------------- | ---------- |
|   | 192.168.1.0/32 | 192.168.1.0 - 192.168.1.0     | 255.255.255.255 | 1          |
|   | 192.168.1.0/31 | 192.168.1.0 - 192.168.1.1     | 255.255.255.254 | 2          |
|   | 192.168.1.0/30 | 192.168.1.0 - 192.168.1.3     | 255.255.255.252 | 4          |
|   | 192.168.1.0/29 | 192.168.1.0 - 192.168.1.7     | 255.255.255.248 | 8          |
|   | 192.168.1.0/28 | 192.168.1.0 - 192.168.1.15    | 255.255.255.240 | 16         |
|   | 192.168.1.0/27 | 192.168.1.0 - 192.168.1.31    | 255.255.255.224 | 32         |
|   | 192.168.1.0/26 | 192.168.1.0 - 192.168.1.63    | 255.255.255.192 | 64         |
|   | 192.168.1.0/25 | 192.168.1.0 - 192.168.1.127   | 255.255.255.128 | 128        |
| C | 192.168.1.0/24 | 192.168.1.0 - 192.168.1.255   | 255.255.255.0   | 256        |
|   | 192.168.0.0/23 | 192.168.0.0 - 192.168.1.255   | 255.255.254.0   | 512        |
|   | 192.168.0.0/22 | 192.168.0.0 - 192.168.3.255   | 255.255.252.0   | 1024       |
|   | 192.168.0.0/21 | 192.168.0.0 - 192.168.7.255   | 255.255.248.0   | 2048       |
|   | 192.168.0.0/20 | 192.168.0.0 - 192.168.15.255  | 255.255.240.0   | 4096       |
|   | 192.168.0.0/19 | 192.168.0.0 - 192.168.31.255  | 255.255.224.0   | 8192       |
|   | 192.168.0.0/18 | 192.168.0.0 - 192.168.63.255  | 255.255.192.0   | 16384      |
|   | 192.168.0.0/17 | 192.168.0.0 - 192.168.127.255 | 255.255.128.0   | 32768      |
| B | 192.168.0.0/16 | 192.168.0.0 - 192.168.255.255 | 255.255.0.0     | 65536      |
|   | 192.168.0.0/15 | 192.168.0.0 - 192.169.255.255 | 255.254.0.0     | 131072     |
|   | 192.168.0.0/14 | 192.168.0.0 - 192.171.255.255 | 255.252.0.0     | 262144     |
|   | 192.168.0.0/13 | 192.168.0.0 - 192.175.255.255 | 255.248.0.0     | 524288     |
|   | 192.160.0.0/12 | 192.160.0.0 - 192.175.255.255 | 255.240.0.0     | 1048576    |
|   | 192.160.0.0/11 | 192.160.0.0 - 192.191.255.255 | 255.224.0.0     | 2097152    |
|   | 192.128.0.0/10 | 192.128.0.0 - 192.191.255.255 | 255.192.0.0     | 4194304    |
|   | 192.128.0.0/9  | 192.128.0.0 - 192.255.255.255 | 255.128.0.0     | 8388608    |
| A | 192.0.0.0/8    | 192.0.0.0   - 192.255.255.255 | 255.0.0.0       | 16777216   |
|   | 192.0.0.0/7    | 192.0.0.0   - 193.255.255.255 | 254.0.0.0       | 33554432   |
|   | 192.0.0.0/6    | 192.0.0.0   - 195.255.255.255 | 252.0.0.0       | 67108864   |
|   | 192.0.0.0/5    | 192.0.0.0   - 199.255.255.255 | 248.0.0.0       | 134217728  |
|   | 192.0.0.0/4    | 192.0.0.0   - 207.255.255.255 | 240.0.0.0       | 268435456  |
|   | 192.0.0.0/3    | 192.0.0.0   - 223.255.255.255 | 224.0.0.0       | 536870912  |
|   | 192.0.0.0/2    | 192.0.0.0   - 255.255.255.255 | 192.0.0.0       | 1073741824 |
|   | 128.0.0.0/1    | 128.0.0.0   - 255.255.255.255 | 128.0.0.0       | 2147483648 |
