# 常用位置: apk 和 数据包
# 公主连结国服
adb pull /data/app/com.bilibili.priconne-1/base.apk
adb pull /data/data/com.bilibili.priconne
# 公主连结日服
adb pull /data/app/jp.co.cygames.princessconnectredive-1/base.apk
adb pull /data/app/jp.co.cygames.princessconnectredive-1/split_config.armeabi_v7a.apk
adb pull /data/data/jp.co.cygames.princessconnectredive
# 闪耀暖暖台服
adb pull /data/app/com.papegames.nn4.tw-2/base.apk
adb pull /data/data/com.papegames.nn4.tw

# 导入
adb push com.papegames.nn4.tw /data/data/
# mumu模拟器
win版
adb connect 127.0.0.1:7555
adb shell
mac版
adb kill-server && adb server
adb devices