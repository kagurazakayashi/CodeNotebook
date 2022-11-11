# bash shell for循环1到100

# 类c语言 (bash)
for ((i=1; i<=100; i ++))
do
    echo $i
done

# in使用 (bash)
for i in {1..100}
do
    echo $i
done

# seq使用 (可以sh)
for i in `seq 1 100`
do
   echo $i
done
