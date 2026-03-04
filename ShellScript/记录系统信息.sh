#/bin/bash
ndate="`date +20%y-%m-%d_%H-%M-%S`"
logdir="/var/log/sys/`date +20%y-%m-%d`"
logfile="$logdir/s_$ndate.log"
if [ ! -x "$logdir" ];then
mkdir -p $logdir
fi
cd $logdir
echo $ndate > "$logfile"
uptime >> "$logfile"
w >> "$logfile"
free -m >> "$logfile"
df -h >> "$logfile"
ps aux >> "$logfile"
netstat >> "$logfile"
echo `date +20%y-%m-%d_%H-%M-%S` >> "$logfile"
