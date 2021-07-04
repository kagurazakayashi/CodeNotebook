csrutil disable
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.dynamic_pager.plist
sudo rm /private/var/vm/*
csrutil enable
# 打开：
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.dynamic_pager.plist