docker pull eclipse-mosquitto
docker run -it -p 1883:1883 -p 9001:9001 -v mosquitto.conf:/mosquitto/config/mosquitto.conf eclipse-mosquitto
# 本地配置文件挂载到 /mosquitto/config/mosquitto.conf
# 将数据保留到 /mosquitto/data
# 登录到 /mosquitto/log/mosquitto.log

# mosquitto.conf：
persistence true
persistence_location /mosquitto/data/
log_dest file /mosquitto/log/mosquitto.log

docker run -it -p 1883:1883 -p 9001:9001 -v mosquitto.conf:/mosquitto/config/mosquitto.conf -v /mosquitto/data -v /mosquitto/log eclipse-mosquitto