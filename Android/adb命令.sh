# 已连接设备
adb devices
# 截图
adb shell screencap -p /storage/emulated/0/t.png
# 下载
adb pull /storage/emulated/0/t.png /Volumes/RamDisk/1.png
# 截图到电脑
adb exec-out screencap -p > /Volumes/RamDisk/sc.png
# 输入文本
adb shell input text hello

# 录制屏幕
adb shell screenrecord /storage/emulated/0/t.mp4
# –size WIDTHxHEIGHT  视频的尺寸，比如 1280x720，默认是屏幕分辨率。
# –bit-rate RATE  视频的比特率，默认是 4Mbps。
# –time-limit TIME  录制时长，单位秒。
# –verbose  输出更多信息。

# 复制文件 设备 -> 电脑
adb pull <设备里的文件路径> [电脑上的目录]
# 示例
adb pull /storage/emulated/0/Download/a.jpg /Volumes/RamDisk/

# 复制文件 电脑 -> 设备
adb push <电脑上的文件路径> <设备里的目录>
adb push /Volumes/RamDisk/a.jpg /storage/emulated/0/Download/

# 安装 APK
adb install — <apk>
# -l  将应用安装到保护目录 /mnt/asec
# -r  允许覆盖安装
# -t  允许安装 AndroidManifest.xml 里 application 指定 android:testOnly="true" 的应用
# -s  将应用安装到 sdcard
# -d  允许降级覆盖安装
# -g  授予所有运行时权限

# 实时资源占用情况
adb shell top

# 强制结束
adb shell am force-stop <packagename>

# 卸载应用
adb uninstall [-k] <packagename>
# -k 保留数据和缓存目录

# 应用列表
adb shell pm list packages — <FILTER>
# 无  所有应用
# -f  显示应用关联的 apk 文件
# -d  只显示 disabled 的应用
# -e  只显示 enabled 的应用
# -s  只显示系统应用
# -3  只显示第三方应用
# -i  显示应用的 installer
# -u  包含已卸载应用
# <FILTER> 包名包含 <FILTER> 字符串

# 查看前台 Activity
adb shell dumpsys activity activities | grep mFocusedActivity

# 服务
adb shell dumpsys activity services [<packagename>]
# <packagename> 表示查看与某个包名相关的 Services，不指定表示查看所有 Services。不一定要给出完整的包名

# 查看应用详细信息
adb shell dumpsys package <packagename>

# 查看日志
adb logcat "*:W"
# V —— Verbose（最低，输出得最多）
# D —— Debug I —— Info
# W —— Warning
# E —— Error
# F—— Fatal
# S —— Silent（最高，啥也不输出）
adb logcat ActivityManager:I MyApp:D *:S

# 查看型号
adb shell getprop ro.product.model
# 电池状况
adb shell dumpsys battery
# 分辨率
adb shell wm size
# 屏幕密度
adb shell wm density
# 显示屏参数
adb shell dumpsys window displays
# android_id
adb shell settings get secure android_id
# Android 系统版本
adb shell getprop ro.build.version.release
# IP 地址
adb shell ifconfig
# Mac 地址
adb shell cat /sys/class/net/wlan0/address
# CPU 信息
adb shell cat /proc/cpuinfo
# 内存信息
adb shell cat /proc/meminfo
# 更多
adb shell cat /system/build.prop
# 重启
adb reboot
# 修改分辨率
adb shell wm size 480x1024
# 修改屏幕密度
adb shell wm density 160
# 修改显示区域留白像素,左、上、右、下
adb shell wm overscan 0,0,0,200

# 模拟点击
# 在屏幕上点击坐标点x=50 y=250的位置：
adb shell input tap 50 250
# 按物理按钮：
db shell input keyevent xx
# 3  HOME 键
# 4  返回键
# 5  打开拨号应用
# 6  挂断电话
# 24  增加音量
# 25  降低音量
# 26  电源键
# 27  拍照（需要在相机应用里）
# 64  打开浏览器
# 82  菜单键
# 85  播放/暂停
# 86  停止播放
# 87  播放下一首
# 88  播放上一首
# 122  移动光标到行首或列表顶部
# 123  移动光标到行末或列表底部
# 126  恢复播放
# 127  暂停播放
# 164  静音
# 176  打开系统设置
# 187  切换应用
# 207  打开联系人
# 208  打开日历
# 209  打开音乐
# 210  打开计算器
# 220  降低屏幕亮度
# 221  提高屏幕亮度
# 223  系统休眠
# 224  点亮屏幕
# 231  打开语音助手
# 276  如果没有 wakelock 则让系统休眠
# 滑动解锁:
adb shell input swipe 300 1000 300 500

# 无线连接
# 让设备在 5555 端口监听 TCP/IP 连接：
adb tcpip 5555
# 通过 IP 地址连接设备：
adb connect <device-ip-address>
# 断开：
adb disconnect <device-ip-address>

# 发送广播
adb shell am broadcast [options] <INTENT>
# 例如，向所有组件广播 BOOT_COMPLETED：
adb shell am broadcast -a android.intent.action.BOOT_COMPLETED
# 只向 org.mazhuang.boottimemeasure/.BootCompletedReceiver 广播 BOOT_COMPLETED：
adb shell am broadcast -a android.intent.action.BOOT_COMPLETED -n org.mazhuang.boottimemeasure/.BootCompletedReceiver
# action  触发时机
# android.net.conn.CONNECTIVITY_CHANGE  网络连接发生变化
# android.intent.action.SCREEN_ON  屏幕点亮
# android.intent.action.SCREEN_OFF  屏幕熄灭
# android.intent.action.BATTERY_LOW  电量低，会弹出电量低提示框
# android.intent.action.BATTERY_OKAY  电量恢复了
# android.intent.action.BOOT_COMPLETED  设备启动完毕
# android.intent.action.DEVICE_STORAGE_LOW  存储空间过低
# android.intent.action.DEVICE_STORAGE_OK  存储空间恢复
# android.intent.action.PACKAGE_ADDED  安装了新的应用
# android.net.wifi.STATE_CHANGE  WiFi 连接状态发生变化
# android.net.wifi.WIFI_STATE_CHANGED  WiFi 状态变为启用/关闭/正在启动/正在关闭/未知
# android.intent.action.BATTERY_CHANGED  电池电量发生变化
# android.intent.action.INPUT_METHOD_CHANGED  系统输入法发生变化
# android.intent.action.ACTION_POWER_CONNECTED  外部电源连接
# android.intent.action.ACTION_POWER_DISCONNECTED  外部电源断开连接
# android.intent.action.DREAMING_STARTED  系统开始休眠
# android.intent.action.DREAMING_STOPPED  系统停止休眠
# android.intent.action.WALLPAPER_CHANGED  壁纸发生变化
# android.intent.action.HEADSET_PLUG  插入耳机
# android.intent.action.MEDIA_UNMOUNTED  卸载外部介质
# android.intent.action.MEDIA_MOUNTED  挂载外部介质
# android.os.action.POWER_SAVE_MODE_CHANGED  省电模式开启

# 关闭 USB 调试
adb shell settings put global adb_enabled 0

# 是否已 root
adb shell
su

# 压力测试
adb shell monkey -p <packagename> -v 500
# 向 <packagename> 指定的应用程序发送 500 个伪随机事件。

# 重启到 Recovery 模式
adb reboot recovery
# 从 Recovery 重启到 Android
adb reboot

# 重启到 Fastboot 模式
adb reboot bootloader

# 更新系统
adb reboot recovery
adb sideload <path-to-update.zip>

# 进程
adb shell ps

# Shell 命令
# cat  显示文件内容
# cd  切换目录
# chmod  改变文件的存取模式/访问权限
# df  查看磁盘空间使用情况
# grep  过滤输出
# kill  杀死指定 PID 的进程
# ls  列举目录内容
# mount  挂载目录的查看和管理
# mv  移动或重命名文件
# ps  查看正在运行的进程
# rm  删除文件
# top  查看进程的资源占用情况

# https://blog.csdn.net/zhonglunshun/article/details/78362439
