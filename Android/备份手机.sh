# 备份手机 备份安卓
adb backup -f backup.ab -apk -shared -all -system
# 手机上会提示为备份文件设置一个密码

# 这个命令的参数如下：
# adb backup [-f ] [-apk|-noapk] [-shared|-noshared] [-all] [-system|nosystem] []

adb backup -f
# 用这个来选择备份文件存储在哪里，例如-f /backup/mybackup.ab将会使文件存储在根磁盘(Windows的C盘等等)下一个名为backup的文件夹里，并且备份文件名为mybackup.ab

adb backup -apk -noapk
# 这个决定是否在备份里包含apk或者仅仅只备份应用数据，个人推荐使用-apk以免有的应用在应用市场找不到，如果不使用则默认的是-noapk

adb backup -shared -noshared
# 这个参数用于决定是否备份设备共享的SD card内容，默认是-noshare，主要包括内部存储中的音乐、图片和视频，因此为保险起见，建议加上-share

adb backup -all
# 这个参数是一种简单地表达“所有应用”的说法，package参数可以选择备份单独的应用，如果你不是备份某个应用，使用-all备份整个系统

adb backup -system -nosystem
# 这个参数决定-all标签是否包含系统应用，默认的是-system，根据情况可选择是否用-nosystem

# 如果你知道应用安装包的名称(例如com.google.android.apps.plus)，就可以使用该参数备份特定应用。

# 如果要恢复数据，将设备连接电脑，打开命令行，输入：
adb restore backup_apk.ab

# https://blog.csdn.net/weixin_28958733/article/details/117541282


# 备份指定程序
adb shell pm list packages
adb backup -nosystem -apk -shared -f pagename.ab pagename

# 解压备份
# https://github.com/nelenkov/android-backup-extractor
java -jar abe.jar unpack D:\abcd.ab D:\aaa.tar

# https://blog.csdn.net/qq_17798399/article/details/124950288
