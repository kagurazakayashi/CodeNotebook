#!/bin/bash
LOGFILE="/mnt/d/server/ssl/logs/uuussl$(date +%Y-%m-%d_%H-%M-%S).log"
STARTCMD="docker exec acme.sh --issue --dns dns_cf --force --dnssleep 300 --debug"
$STARTCMD --keylength 4096 -d "uuu.moe" -d "*.uuu.moe" | tee -a $LOGFILE
$STARTCMD --keylength ec-256 -d "uuu.moe" -d "*.uuu.moe" | tee -a $LOGFILE
$STARTCMD --keylength 4096 -d "yashi.moe" -d "*.yashi.moe" | tee -a $LOGFILE
$STARTCMD --keylength ec-256 -d "yashi.moe" -d "*.yashi.moe" | tee -a $LOGFILE
$STARTCMD --keylength 4096 -d "miyabi.moe" -d "*.miyabi.moe" | tee -a $LOGFILE
$STARTCMD --keylength ec-256 -d "miyabi.moe" -d "*.miyabi.moe" | tee -a $LOGFILE
$STARTCMD --keylength 4096 -d "masae.moe" -d "*.masae.moe" | tee -a $LOGFILE
$STARTCMD --keylength ec-256 -d "masae.moe" -d "*.masae.moe" | tee -a $LOGFILE
STARTCMD="docker exec acme.sh --issue --dns dns_ali --force --dnssleep 300 --debug"
$STARTCMD --keylength ec-256 -d "yoooooooooo.com" -d "*.yoooooooooo.com" | tee -a $LOGFILE
docker exec acme.sh --deploy -d "yoooooooooo.com" --deploy-hook ali_cdn | tee -a $LOGFILE
$STARTCMD --keylength ec-256 -d "uuumoe.com" -d "*.uuumoe.com" | tee -a $LOGFILE
docker exec acme.sh --deploy -d "uuumoe.com" --deploy-hook ali_cdn | tee -a $LOGFILE
xz -z -e -9 $LOGFILE