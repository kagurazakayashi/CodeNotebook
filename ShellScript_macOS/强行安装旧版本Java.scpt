# 强行安装旧版本Java
# https://support.apple.com/kb/DL1572?locale=zh_CN
set theDMG to choose file with prompt "Please select javaforosx.dmg:" of type {"dmg"}
do shell script "hdiutil mount " & quoted form of POSIX path of theDMG
do shell script "pkgutil --expand /Volumes/Java\\ for\\ macOS\\ 2017-001/JavaForOSX.pkg ~/tmp"
do shell script "hdiutil unmount /Volumes/Java\\ for\\ macOS\\ 2017-001/"
do shell script "sed -i '' 's/return false/return true/g' ~/tmp/Distribution"
do shell script "pkgutil --flatten ~/tmp ~/Desktop/ModifiedJava6Install.pkg"
do shell script "rm -rf ~/tmp"
display dialog "Modified ModifiedJava6Install.pkg saved on desktop" buttons {"Ok"}

# 强行运行Paho
# https://www.cnblogs.com/starstarstar/p/9784073.html
# 旧版本Paho
# https://www.eclipse.org/downloads/download.php?file=/paho/1.0/org.eclipse.paho.mqtt.utility-1.0.0.jar