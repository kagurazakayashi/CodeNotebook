#!/bin/bash
# docker-acme免费证书-自用配置-生成
LOGFILE="/mnt/d/server/ssl/logs/uuussl$(date +%Y-%m-%d_%H-%M-%S).log"
# dns_cf
STARTCMD="docker exec acme.sh --issue --dns dns_cf --force --debug"
$STARTCMD --keylength 4096 -d "uuu.moe" -d "*.uuu.moe" 2>&1 | tee -a $LOGFILE
$STARTCMD --keylength ec-256 -d "uuu.moe" -d "*.uuu.moe" 2>&1 | tee -a $LOGFILE
$STARTCMD --keylength 4096 -d "yashi.moe" -d "*.yashi.moe" 2>&1 | tee -a $LOGFILE
$STARTCMD --keylength ec-256 -d "yashi.moe" -d "*.yashi.moe" 2>&1 | tee -a $LOGFILE
$STARTCMD --keylength 4096 -d "miyabi.moe" -d "*.miyabi.moe" 2>&1 | tee -a $LOGFILE
$STARTCMD --keylength ec-256 -d "miyabi.moe" -d "*.miyabi.moe" 2>&1 | tee -a $LOGFILE
$STARTCMD --keylength 4096 -d "masae.moe" -d "*.masae.moe" 2>&1 | tee -a $LOGFILE
$STARTCMD --keylength ec-256 -d "masae.moe" -d "*.masae.moe" 2>&1 | tee -a $LOGFILE
# dns_ali
STARTCMD="docker exec acme.sh --issue --dns dns_ali --force --debug"
$STARTCMD --keylength ec-256 -d "yoooooooooo.com" -d "*.yoooooooooo.com" 2>&1 | tee -a $LOGFILE
docker exec acme.sh --deploy -d "yoooooooooo.com" --deploy-hook ali_cdn 2>&1 | tee -a $LOGFILE
$STARTCMD --keylength ec-256 -d "uuumoe.com" -d "*.uuumoe.com" 2>&1 | tee -a $LOGFILE
docker exec acme.sh --deploy -d "uuumoe.com" --deploy-hook ali_cdn 2>&1 | tee -a $LOGFILE
xz -z -e -9 $LOGFILE
