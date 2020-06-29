# 临时：
# 听到启动提示音后，按住Command（⌘） - V组合键，进入详细模式。

# 永久：
sudo nvram boot-args="-v"
# nvram: Error getting variable - 'boot-args': (iokit/common) data was not found
sudo nvram boot-args=kext-dev-mode=1
sudo nvram boot-args=kext-dev-mode=0
sudo nvram boot-args="-v"

# 查看：
sudo nvram boot-args

# 控制开机音的音量:
# 1. 静音－使用下面命令:
sudo nvram SystemAudioVolume="%80"
# 2. 设置特殊音量, 比如声音很大:
sudo nvram SystemAudioVolume=2
# 3. 设置音量为0:
sudo nvram SystemAudioVolume="%00"