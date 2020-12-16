set apk_file=%1%
adb.exe devices
adb.exe install -r %apk_file%
sleep 3