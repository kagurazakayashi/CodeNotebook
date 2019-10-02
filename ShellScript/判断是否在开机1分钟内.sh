#!/bin/bash
# yashi_autostart
proc1stat=$(stat -t /proc/1 | awk '{print $0}')
proc1statarr=(${proc1stat//,/})
proc1time=${proc1statarr[12]}
timeStamp=$(date +%s)
bashuptime=$(($timeStamp - $proc1time))
if [ $bashuptime -lt 60 ] then
    /usr/bin/lnmp start
fi
unset proc1stat
unset proc1statarr
unset proc1time
unset timeStamp
unset bashuptime