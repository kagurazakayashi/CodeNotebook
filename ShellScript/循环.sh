# 多行
for f in `find . -iname "*.mp4"`
do
    echo $f
done

for f in ./GIF/*.gif
do
    echo ${f%%.*} #去除扩展名
done

# 单行
for f in *.png; do echo $f; done

# 查找命令循环文件
find '/var/process_log/' -name '*.log' -exec basename {} \;

# 次数
for i in {1..348}
do
echo $i
done

for j in $(seq 1 5)
do
    echo $j
done