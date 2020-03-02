# Mosquitto桥接模式

通常选取一台broker作为bridge节点，
在其配置文件（mosquitto.conf）中添加桥接选项：

vim /etc/mosquitto/mosquitto.conf

```
connection bridge1
address 192.168.1.102:1883
topic # both 0

connection bridge2
address 192.168.1.103:1883
topic /sensor/temperature in 1
```

- `connection`: 为其他broker起的名字
- `address`: 其他broker的IP和端口
- `topic`: 允许本地broker和对方broker之间传递的消息主题
  - `#`: 所有主题消息都将被传递
  - `both/in/out`: 是指允许的消息方向
    - `in`: 只能是从对方到本地
    - `out`: 只能是从本地到对方
    - `both`: 都可以
  - `0`: QoS