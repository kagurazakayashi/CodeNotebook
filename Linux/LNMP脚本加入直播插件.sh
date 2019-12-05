# lnmp1.4-full/include/upgrade_nginx.sh
echo "============================check files=================================="

    Install_Nginx_Openssl
    Tar_Cd nginx-${Nginx_Version}.tar.gz nginx-${Nginx_Version}
    if echo ${Nginx_Version} | grep -Eqi '^[0-1].[5-8].[0-9]' || echo ${Nginx_Version} | grep -Eqi '^1.9.[1-4]$'; then
        ./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_spdy_module --with-http_gzip_static_module --with-ipv6 --with-http_sub_module ${Nginx_With_Openssl} ${NginxMAOpt} ${Nginx_Modules_Options} --add-module=/mnt/data/install/nginx-http-flv-module
    else
        ./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_v2_module --with-http_gzip_static_module --with-ipv6 --with-http_sub_module ${Nginx_With_Openssl} ${NginxMAOpt} ${Nginx_Modules_Options} --add-module=/mnt/data/install/nginx-http-flv-module
    fi
    make

# lnmp1.5-full/include/upgrade_nginx.sh

echo "============================check files=================================="

Install_Nginx_Openssl
Install_Nginx_Lua
Tar_Cd nginx-${Nginx_Version}.tar.gz nginx-${Nginx_Version}
Get_Dist_Version
if [[ "${DISTRO}" = "Fedora" && "${Fedora_Version}" = "28" ]]; then
    patch -p1 < ${cur_dir}/src/patch/nginx-libxcrypt.patch
fi
if gcc -dumpversion|grep -q "^[8]"; then
    patch -p1 < ${cur_dir}/src/patch/nginx-gcc8.patch
fi
if echo ${Nginx_Version} | grep -Eqi '^[0-1].[5-8].[0-9]' || echo ${Nginx_Version} | grep -Eqi '^1.9.[1-4]$'; then
    ./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_spdy_module --with-http_gzip_static_module --with-ipv6 --with-http_sub_module ${Nginx_With_Openssl} ${Nginx_Module_Lua} ${NginxMAOpt} ${Nginx_Modules_Options} --add-module=/mnt/data/install/nginx-http-flv-module
else
    ./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_v2_module --with-http_gzip_static_module --with-http_sub_module --with-stream --with-stream_ssl_module ${Nginx_With_Openssl} ${Nginx_Module_Lua} ${NginxMAOpt} ${Nginx_Modules_Options} --add-module=/mnt/data/install/nginx-http-flv-module
fi
    make -j `grep 'processor' /proc/cpuinfo | wc -l`
if [ $? -ne 0 ]; then
    make
fi
