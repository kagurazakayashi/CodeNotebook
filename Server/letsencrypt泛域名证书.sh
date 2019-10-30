# 重新申请签发证书
acme.sh --renew --dns -d yoooooooooo.com -d *.yoooooooooo.com

# 签发证书
（开代理）
curl https://get.acme.sh -o acme.sh
sh acme.sh

vim ~/.bashrc
alias acme.sh=~/.acme.sh/acme.sh
acme.sh

crontab -l
34 0 * * * "/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" > /dev/null

export Ali_Key="xxx"
export Ali_Secret="xxx"
acme.sh --issue --dns dns_ali -d yoooooooooo.com -d *.yoooooooooo.com
# Ali_Key 和 Ali_Secret 将被保存在 ~/.acme.sh/account.conf , 命令中 dns_ali 指明使用 阿里的dns

ls ~/.acme.sh #/yoooooooooo.com

cat ~/.acme.sh/yoooooooooo.com/fullchain.cer >/mnt/data/docker/volumes/ip/_data/c/yoo.cer
cat ~/.acme.sh/yoooooooooo.com/yoooooooooo.com.key >/mnt/data/docker/volumes/ip/_data/c/yoo.key
openssl dhparam -out /mnt/data/docker/volumes/ip/_data/c/yoo.pem 4096

# nginx
        listen 443 ssl http2;
        listen [::]:443 ssl http2;
        
        ssl_certificate /d/c/ssl.cer;
        ssl_certificate_key /d/c/ssl.key;
        ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3;
        ssl_ciphers "ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES256-SHA384:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-RSA-AES256-SHA:AES128-SHA:AES256-SHA:DES-CBC3-SHA:!aNULL";
        ssl_ecdh_curve secp384r1;
        ssl_dhparam /d/c/yoo.pem;
        ssl_prefer_server_ciphers on;
        ssl_stapling on;
        ssl_stapling_verify on;
        ssl_trusted_certificate /d/c/yoo.cer;

nginx -s reload

https://juejin.im/post/5b6542ed51882519d3468d6d