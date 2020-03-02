# mosquitto MQTT CLI
# mosquitto提供了工具可以测试MQTT服务

mosquitto
mosquitto_passwed
mosquitto_pub
mosquitto_sub
# 于是我们可以用下面的命令来发布一条消息

mosquitto_pub -h 127.0.0.1 -d -t "mqtttest" -m "Hello, MQTT. This is my first message."

# 运行
# Client mosqpub/6660-phodal.loc sending CONNECT
# Client mosqpub/6660-phodal.loc received CONNACK
# Client mosqpub/6660-phodal.loc sending PUBLISH (d0, q0, r0, m1, 'lettuce', ... (38 bytes))
# Client mosqpub/6660-phodal.loc sending DISCONNECT

# 接着打开http://mqtt.phodal.com/topics/lettuce

# 当然我们也可以用下面的命令来订阅消息
mosquitto_sub -h mqtt.phodal.com -d -t lettuce
# 来监听。