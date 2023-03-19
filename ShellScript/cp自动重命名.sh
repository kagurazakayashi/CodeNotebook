# cp自动重命名 同名文件自动重命名
find / -name "*.txt" -type f -exec cp --backup=numbered "{}" "~/txt/" \;
# 1.txt
# 1.txt.~1~
# 1.txt.~2~

# 后面再添回一个扩展名
for f in *~
do
    echo mv "$f" "$f.txt"
    mv "$f" "$f.txt"
done

# 取出mac中所有icns图标，mac用gcp
brew install coreutils
sudo find / -name "*.icns" -type f -exec gcp --backup=numbered "{}" "/Volumes/R/icns/" \;
for f in *~; do mv "$f" "$f.icns"; done
