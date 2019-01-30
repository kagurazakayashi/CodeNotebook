# https://certbot.eff.org/lets-encrypt/centosrhel7-nginx
# https://github.com/0xJacky/cdn_cert

yum -y install yum-utils
yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional
yum install python2-certbot-nginx
certbot --nginx

git clone https://github.com/0xJacky/cdn_cert.git
pip install aliyun-python-sdk-cdn sqlalchemy
pip install --upgrade --force-reinstall 'requests==2.6.0' urllib3
cd cdn_cert
cp settings-template.py settings.py
vim settings.py
python update.py -a
python update.py -ls

# 证书存储位置 /etc/letsencrypt/live