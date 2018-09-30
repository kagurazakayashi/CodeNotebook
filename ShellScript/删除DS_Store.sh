defaults write com.apple.desktopservices DSDontWriteNetworkStores true
sudo find ./ -name ".DS_Store" -depth -exec rm {} \;

sudo find ./ -name "._*" -depth -exec rm {} \;

#Windows:
DEL /f/s/q/a .DS_Store
DEL /f/s/q/a ._*
