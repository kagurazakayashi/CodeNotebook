# 五种方法：
i=`expr $i + 1`;
let i+=1;
((i++));
i=$[$i+1];
i=$(( $i + 1 ))

# 利用for：
for j in $(seq 1 5)
do
    echo $j
done