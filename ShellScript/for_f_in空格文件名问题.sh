# for f in `find` 处理带空格文件名会有问题 # while 代替 for find
while IFS= read -r -d '' f; do
    echo $f
done < <(find ~ -name "*.txt" -print0 2>/dev/null)
# https://blog.csdn.net/weixin_33142377/article/details/116968344
