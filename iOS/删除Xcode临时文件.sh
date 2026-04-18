# 删除Xcode临时文件
cd "/Users/yashi/Library/Developer/DVTDownloads/"
mount | grep "MetalToolchain" | awk '{print $3}' | xargs -I {} sudo hdiutil detach {} -force
rm -rf "~/Library/Developer/DVTDownloads" "~/Library/Developer/Xcode/DerivedData" "~/Library/Developer/CoreSimulator/Caches"
