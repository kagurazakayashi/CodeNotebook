# https://cn.wordpress.org/
# https://wordpress.org/
curl -o wp.tar.gz https://wordpress.org/latest.tar.gz
tar -xzvf wp.tar.gz
cp -rfv wordpress/* /www/yashi/
rm -rf wordpress
rm -f wp.tar.gz
