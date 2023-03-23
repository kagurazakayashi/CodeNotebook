# 1、查看手机中安装的apk列表：
adb shell pm list package

# 2、根据包名找出apk在内部存储空间的路径：
adb shell pm path com.papegames.nn4.tw
# package:/data/app/com.papegames.nn4.tw-1/base.apk

# 3、使用adb pull命令将apk文件导出：
adb pull /data/app/com.papegames.nn4.tw
# /data/app/com.papegames.nn4.tw-1/: 20 files pulled. 12.9 MB/s (149834276 bytes in 11.101s)

#
adb push com.papegames.nn4.tw /data/app/