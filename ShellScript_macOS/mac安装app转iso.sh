# 1. 磁盘工具创建稀疏磁盘映像 mac.sparseimage
# 2.
sudo /Applications/Install\ macOS\ Monterey.app/Contents/Resources/createinstallmedia --volume /Volumes/macinstall #--applicationpath /Applications/Install\ macOS\ Monterey.app
# 3. 卸载映像。
# 4. 调整映像文件的容量，删除所有未使用的空间
hdiutil resize -size `hdiutil resize -limits /Volumes/0wew0-1T/macinstall.sparseimage | tail -n 1 | awk '{ print $1 }'`b /Volumes/0wew0-1T/macinstall.sparseimage
# 5. 转换成 ISO 格式
hdiutil convert /Volumes/0wew0-1T/macinstall.sparseimage -format UDTO -o /Volumes/0wew0-1T/macinstall
# 会自动加 cdr 扩展名，可以直接改成 iso