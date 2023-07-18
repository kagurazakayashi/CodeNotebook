#!/bin/sh
date
pwd
ls -ahl . conf
/usr/sbin/privoxy --version
/usr/sbin/privoxy --config-test conf/privoxy/config || echo CONF_ERR!
/usr/sbin/privoxy conf/privoxy/config &
./v2ray test -c conf/v2ray.config.json
./v2ray run -c conf/v2ray.config.json
date
echo END
