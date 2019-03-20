#！/bin/sh
resh=0
while :
do
    echo [进程监视] 第 $resh 次重试 : `date`
    echo 'code'
    echo [进程监视] 第 $resh 次中断 : `date`
    resh=`expr $resh + 1`;
    sleep 1
done