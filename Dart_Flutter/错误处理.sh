# Error connecting to the service protocol: failed to connect
# 由于开启了代理导致dartvm启动出现问题，flutter一启动就白屏闪退
flutter doctor
# [!] Proxy Configuration
#     ! NO_PROXY is not set
# Linux
vim /etc/profile
export NO_PROXY=localhost,127.0.0.1,::1
# Windows 添加环境变量
set NO_PROXY=localhost,127.0.0.1,::1
