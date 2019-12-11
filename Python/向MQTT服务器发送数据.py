import paho.mqtt.client as mqtt
import time
import random
import json

HOST = "192.168.2.150"
PORT = 1883
def on_connect(client, userdata, flags, rc):
    print("已连接，代码："+str(rc))

def on_message(client, userdata, msg):
    print("收到消息："+msg.topic+" "+msg.payload.decode("utf-8"))

def floatrandom(min, max):
    return round((random.randint(min, max) * 0.01),2)

def getmsg():
    dataarr = {
        "dev": "YS-9999999",
        "cod": 1,
        "dat": "test"
    }
    return json.dumps(dataarr)

if __name__ == '__main__':
    timestr = time.strftime('%Y%m%d%H%M%S',time.localtime(time.time()))
    print("["+timestr+"]正在连接到 MQTT 服务器...")
    client_id = "yashiemu"
    client = mqtt.Client(client_id) 
    client.username_pw_set("user", "password") 
    client.on_connect = on_connect
    client.on_message = on_message
    client.connect(HOST, PORT, 60)
    print("发送消息...")
    txt = getmsg()
    print(txt)
    client.publish("/device/testdev", txt, qos=0, retain=False)
    print("断开连接")
    client.disconnect()