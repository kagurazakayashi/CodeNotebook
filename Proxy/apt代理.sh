# apt代理
sudo vim /etc/apt/apt.conf
sudo vim /etc/apt/apt.conf.d/proxy.conf

# Acquire::http::Proxy "http://proxy-IP-address:proxyport/";
# Acquire::https::Proxy "http://proxy-IP-address:proxyport/";

# 需要用户名和密码:
# Acquire::http::Proxy "http://username:password@proxy-IP-address:proxyport";
# Acquire::https::Proxy "http://username:password@proxy-IP-address:proxyport";
