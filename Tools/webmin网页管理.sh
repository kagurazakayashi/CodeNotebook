# https://webmin.com/download/
curl -o setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh
sh setup-repos.sh
apt install webmin --install-recommends -y

firewall-cmd --zone=public --add-port=10000/tcp --permanent
firewall-cmd --reload


# 修改URL路径 https://ipnet.xyz/2021/06/nginx-reverse-proxy-and-webmin/

vim /etc/webmin/miniserv.conf
cookiepath=/webmin01
trust_real_ip=1
logouttimes=

vim /etc/webmin/config
referers=mypage.local.lan
webprefix=/webmin01
relative_redir=0

systemctl restart webmin
systemctl status webmin
