# 常用位置: apk 和 数据包
# 查看手机中安装的apk列表
adb shell pm list package
# 查看路径
adb shell pm path com.bilibili.priconne

# 公主连结国服
# APK
adb pull /data/app/com.bilibili.priconne-2/base.apk
mv base.apk com.bilibili.priconne-2.apk
# APK压缩存放
adb exec-out "cat /data/app/com.bilibili.priconne-2/base.apk" | xz -z -9 -e -T 12 >com.bilibili.priconne-2.apk.xz
# 数据包
adb pull /data/data/com.bilibili.priconne
# 数据包压缩存放
adb exec-out "tar -zcf - /data/data/com.bilibili.priconne 2>/dev/null" | xz -z -9 -e -T 12 >com.bilibili.priconne.tar.xz
# 导入
adb install com.bilibili.priconne-2.apk
adb push com.bilibili.priconne /data/data/

# 公主连结日服
# APK
adb pull /data/app/jp.co.cygames.princessconnectredive-2/base.apk
mv base.apk jp.co.cygames.princessconnectredive.apk
adb pull /data/app/jp.co.cygames.princessconnectredive-2/split_config.armeabi_v7a.apk
# APK压缩存放
adb exec-out "cat /data/app/jp.co.cygames.princessconnectredive-2/base.apk" | xz -z -9 -e -T 12 >jp.co.cygames.princessconnectredive-2.apk.xz
adb exec-out "cat /data/app/jp.co.cygames.princessconnectredive-2/split_config.armeabi_v7a.apk" | xz -z -9 -e -T 12 >split_config.armeabi_v7a.apk.xz
# 数据包
adb pull /data/data/jp.co.cygames.princessconnectredive
# 数据包压缩存放
adb exec-out "tar -zcf - /data/data/jp.co.cygames.princessconnectredive 2>/dev/null" | xz -z -9 -e -T 12 >jp.co.cygames.princessconnectredive.tar.xz
# 导入
adb install jp.co.cygames.princessconnectredive.apk
adb push jp.co.cygames.princessconnectredive /data/data/

# 闪耀暖暖台服
adb pull /data/app/com.papegames.nn4.tw-2/base.apk
adb pull /data/data/com.papegames.nn4.tw

# 导入
adb push com.papegames.nn4.tw /data/data/

# 模拟器
win版
adb connect 127.0.0.1:7555 # mumu
adb connect 127.0.0.1:5555 # 雷电
adb shell
mac版
adb kill-server && adb server
adb devices
