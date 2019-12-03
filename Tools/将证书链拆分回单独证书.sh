#!/usr/bin/bash
# 神楽坂雅詩
rm "cert.pem"
rm "ca.pem"
fileid=0
cat "fullchain.pem" | while read line
do
    echo -n "."
    if [ "${line}" != "" ]; then
        if [ "${line:0:10}" == "-----BEGIN" ]; then
            fileid=`expr $fileid + 1`
            echo -n "$fileid"
        fi
        if [ "$fileid" -eq "1" ]; then
            echo "${line}">>"cert.pem"
        else
            echo "${line}">>"ca.pem"
        fi
    fi
done
echo "OK"