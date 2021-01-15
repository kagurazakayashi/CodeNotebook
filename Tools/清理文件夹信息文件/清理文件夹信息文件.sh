defaults write com.apple.desktopservices DSDontWriteNetworkStores true

find . -name ".DS_Store" -or -name "._*" -or -name "Thumbs.db" -depth -exec rm {} \;