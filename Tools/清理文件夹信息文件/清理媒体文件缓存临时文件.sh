echo 清理媒体文件缓存临时文件
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
find . -name ".DS_Store" -or -name "._*" -or -name "Thumbs.db" -depth -exec rm {} \;
