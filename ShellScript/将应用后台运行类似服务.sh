#!/bin/sh

#main method
JAR_NAME="worker.jar"

#USAGE is the message if this script is called without any options
USAGE="Usage: $0 {start,stop,status,restart}"

#check existance
exists() {
    pid=`ps -ef|grep $JAR_NAME|grep -v grep|awk '{print $2}'`
    if [ -z "${pid}" ]; then
        return 1
    else
        return 0
    fi
}

start() {
    exists
    if [ $? -eq 0 ]; then
        echo "${JAR_NAME} is already running. pid=${pid}"
    else
        nohup java -jar /server/$JAR_NAME >/server/worker/logs/worker-$(date +%Y-%m-%d).log 2>&1 &
    fi
}

stop() {
    exists
    if [ $? -eq 0 ]; then
        kill -9 $pid
    else
        echo "${JAR_NAME} is not running"
    fi
}

stop
sleep 1
start