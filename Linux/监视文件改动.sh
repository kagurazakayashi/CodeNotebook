#!/bin/bash
# nohup sh /server/ota/chkdir.sh > /server/ota/chkdir.log
date
echo 监视启动
export CNROMS_SRC=/server/apache-tomcat-9.0.17/webapps/upload/ota # 同步的路径
inotifywait -m -q -e modify,move_self,create,delete,move,close_write $CNROMS_SRC |
    while read event; do
        #执行同步的命令
        date
        rsync -av $CNROMS_SRC/ /www/wwwroot/ota/
        chown -Rv www:www /www/wwwroot/ota
        chmod -Rv 770 /www/wwwroot/ota
    done

# 配合服务使用

# [Unit]
# Description=OTA-Chmod
# After=network.target

# [Service]
# Type=simple
# ExecStart=/server/ota/chkdir.sh
# ExecReload=/bin/kill -s HUP $MAINPID
# ExecStop=/bin/kill -s QUIT $MAINPID

# [Install]
# WantedBy=multi-user.target