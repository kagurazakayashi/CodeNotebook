# adb查看版本号 安卓版本号

# 查看 Android版本号（即系统版本）
adb shell getprop ro.build.version.release
# 13

# 查看 API 版本（即 SDK 版本）
adb shell getprop ro.build.version.sdk
# 33

# 如果想获取更多系统相关的信息，可以使用
adb shell getprop
# 或者筛选相关信息
adb shell getprop | grep version

# 适用于新版 ADB (可以获取更多与版本相关的系统属性)
adb shell dumpsys system_properties | grep version
