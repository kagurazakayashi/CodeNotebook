#!/bin/sh
# 自动检查网站可访问性，出现异常自动重启 tomcat 。
# by 神楽坂雅詩
#
url="http://www.mytongdy.com/observer/client/"
log="/var/log/autoRestartTomcat.log"
#
proc1stat=$(stat -t /proc/1 | awk '{print $0}')
proc1statarr=(${proc1stat//,/})
proc1time=${proc1statarr[12]}
timeStamp=$(date +%s)
bashuptime=$(($timeStamp - $proc1time))
if [ $bashuptime -gt 120 ]
then
    httpRes=`curl -I $url 2>/dev/null | grep 200 | awk '{print $2}'`
    httpGrep=$(echo $httpRes | grep "200")
    if [[ "$httpGrep" != "" ]]
    then
        echo [`date -R`] "没有问题。">>$log
    else
        echo [`date -R`] "发现异常$httpRes，再试一次。">>$log
        httpRes=`curl -I $url 2>/dev/null | grep 200 | awk '{print $2}'`
        httpGrep=$(echo $httpRes | grep "200")
        if [[ "$httpGrep" != "" ]]
        then
            echo [`date -R`] "问题已经解决。">>$log
        else
            echo [`date -R`] "确认发现异常$httpRes，停止 tomcat ...">>$log
            sh /server/apache-tomcat-9.0.17/bin/shutdown.sh>>$log
            kill -9 `ps -ef|grep tomcat|awk '{print $2}'`>>$log
            sleep 10
            echo [`date -R`] "启动 MyTongdy 所有服务 ...">>$log
            sh /server/StartMyTongdy.sh>>$log
            sleep 10
            httpRes=`curl -I $url 2>/dev/null | grep 200 | awk '{print $2}'`
            httpGrep=$(echo $httpRes | grep "200")
            if [[ "$httpGrep" != "" ]]
            then
                echo [`date -R`] "问题已经解决。">>$log
            else
                echo [`date -R`] "已尝试解决问题$httpRes，但没有成功，稍后再试。">>$log
            fi
        fi
    fi
fi