#!/bin/bash
LOGFILE="/mnt/d/server/ssl/logs/uuussl$(date +%Y-%m-%d_%H-%M-%S).log"
ACMEDIR="/var/lib/docker/volumes/ssl_acme/_data"
NGINXDIR="/var/lib/docker/volumes/nginx_conf/_data/ssl"
cd "$ACMEDIR"
docker exec acme.sh --list --debug | tee $LOGFILE
docker exec acme.sh --cron --force --home "/root/.acme.sh" --debug | tee -a $LOGFILE
7z a -mx9 "uuussl_$(date +%Y-%m-%d_%H-%M-%S).7z" '-xr!*.7z' "$ACMEDIR"
docker stop nginx
cp -f "$ACMEDIR/uuu.moe/fullchain.cer" "$NGINXDIR/uuu.moe.rsa.pem" | tee -a $LOGFILE
cp -f "$ACMEDIR/uuu.moe_ecc/fullchain.cer" "$NGINXDIR/uuu.moe.ecc.pem" | tee -a $LOGFILE
cp -f "$ACMEDIR/uuu.moe/uuu.moe.key" "$NGINXDIR/uuu.moe.rsa.key" | tee -a $LOGFILE
cp -f "$ACMEDIR/uuu.moe_ecc/uuu.moe.key" "$NGINXDIR/uuu.moe.ecc.key" | tee -a $LOGFILE
cp -f "$ACMEDIR/yashi.moe/fullchain.cer" "$NGINXDIR/yashi.moe.rsa.pem" | tee -a $LOGFILE
cp -f "$ACMEDIR/yashi.moe_ecc/fullchain.cer" "$NGINXDIR/yashi.moe.ecc.pem" | tee -a $LOGFILE
cp -f "$ACMEDIR/yashi.moe/yashi.moe.key" "$NGINXDIR/yashi.moe.rsa.key" | tee -a $LOGFILE
cp -f "$ACMEDIR/yashi.moe_ecc/yashi.moe.key" "$NGINXDIR/yashi.moe.ecc.key" | tee -a $LOGFILE
cp -f "$ACMEDIR/miyabi.moe/fullchain.cer" "$NGINXDIR/miyabi.moe.rsa.pem" | tee -a $LOGFILE
cp -f "$ACMEDIR/miyabi.moe_ecc/fullchain.cer" "$NGINXDIR/miyabi.moe.ecc.pem" | tee -a $LOGFILE
cp -f "$ACMEDIR/miyabi.moe/miyabi.moe.key" "$NGINXDIR/miyabi.moe.rsa.key" | tee -a $LOGFILE
cp -f "$ACMEDIR/miyabi.moe_ecc/miyabi.moe.key" "$NGINXDIR/miyabi.moe.ecc.key" | tee -a $LOGFILE
cp -f "$ACMEDIR/masae.moe/fullchain.cer" "$NGINXDIR/masae.moe.rsa.pem" | tee -a $LOGFILE
cp -f "$ACMEDIR/masae.moe_ecc/fullchain.cer" "$NGINXDIR/masae.moe.ecc.pem" | tee -a $LOGFILE
cp -f "$ACMEDIR/masae.moe/masae.moe.key" "$NGINXDIR/masae.moe.rsa.key" | tee -a $LOGFILE
cp -f "$ACMEDIR/masae.moe_ecc/masae.moe.key" "$NGINXDIR/masae.moe.ecc.key" | tee -a $LOGFILE
docker start nginx
docker exec acme.sh --deploy -d "yoooooooooo.com" --deploy-hook ali_cdn --debug | tee -a $LOGFILE
docker exec acme.sh --deploy -d "uuumoe.com" --deploy-hook ali_cdn --debug | tee -a $LOGFILE
xz -z -e -9 $LOGFILE