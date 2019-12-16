# 多行
for f in `find . -iname "*.mp4"`
do
    echo $f
done

# 单行
for f in *.png; do echo $f; done

# 次数
for i in {1..348}
do
echo $i
done

for j in $(seq 1 5)
do
    echo $j
done