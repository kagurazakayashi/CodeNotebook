#!/bin/bash
echo  清理媒体文件缓存临时文件
find . -type f -name "Thumbs.db" -exec rm -vf {} \;
find . -type f -name ".DS_Store" -exec rm -vf {} \;
find . -type f -name "desktop.ini" -exec rm -vf {} \;
find . -type f -name "ehthumbs.db" -exec rm -vf {} \;
find . -type f -name ".AppleDouble" -exec rm -vf {} \;
find . -type f -name ".Spotlight-V100" -exec rm -vf {} \;
find . -type d -name ".Trashes" -exec rm -rf {} \;
find . -type d -name ".TemporaryItems" -exec rm -rf {} \;
find . -type f -name "~$*" -exec rm -vf {} \;
find . -type f -name ".nfs*" -exec rm -vf {} \;
find . -type f -name "*.swp" -exec rm -vf {} \;
find . -type f -name "*.bak" -exec rm -vf {} \;
find . -type f -name "*.tmp" -exec rm -vf {} \;
find . -type f -name "._*" -exec rm -vf {} \;
