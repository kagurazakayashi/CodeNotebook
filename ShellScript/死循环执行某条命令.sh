#!/bin/sh
# sh死循环执行某条命令
restartl=restart.log
rm -f $restartl
restarti=0
while :
do
    restarts=`date`
    restarts="START $restarti : $restarts"
    echo
    echo $restarts
    echo $restarts >>$restartl
    echo
    nice -n 19 echo =====COMMAND=====
    restarts=`date`
    restarts="STOP $restarti : $restarts"
    echo
    echo $restarts
    echo $restarts >>$restartl
    echo
    restarti=`expr $restarti + 1`;
    sleep 5
done
