#!/bin/sh
httpRes=`curl -I http://127.0.0.1 2>/dev/null | grep 200 | awk '{print $2}'`
if [ "$httpRes" = "200" ]
then
    echo [`date -R`] "没有问题。"
else
    echo [`date -R`] "发现异常$httpRes，再试一次。"
    httpRes=`curl -I http://127.0.0.1 2>/dev/null | grep 200 | awk '{print $2}'`
    if [ "$httpRes" = "200" ]
    then
        echo [`date -R`] "问题已经解决。"
    else
        echo [`date -R`] "确认发现异常$httpRes，开始采取操作。"
    fi
fi