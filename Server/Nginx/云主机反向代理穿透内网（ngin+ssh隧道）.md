# 云主机反向代理穿透内网（nginx + ssh隧道）

- 云主机：
  - 云主机，IP 地址下记 <server_ip> ，使用 nginx 作为反向代理的 web 服务器监听对外端口，下记为 `80` ，将请求转发 ssh 隧道监听的端口 `2222` 。
- 家庭内网私有服务:
  - 建立ssh隧道连接，将请求接受并转发服务端口 `8080`

# 云主机部署

## 安装nginx

## 配置nginx
在 `/etc/nginx/conf.d/` 下随意创建一个 `.conf` 后缀的配置文件，下记为 `proxy.conf` ，作为该反向代理的配置文件。该文件会在 nginx 的主配置文件 `/etc/nginx/nginx.conf` 中的下述代码段中引入。

`include /etc/nginx/conf.d/*.conf;`

在 `proxy.conf` 文件中添加下述内容

```
server {
   listen 80; # 这里为对外访问端口
   server_name localhost;
   location /{
        # 转发时调整请求头信息
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_redirect off;
        proxy_set_header Connection "upgrade";
    
        # 转发至ssh 监听端口2222
        proxy_pass http://127.0.0.1:2222;
   }
}
```

## 加载nginx服务
- nginx配置开机启动
  - `systemctl enable nginx`
- nginx服务重启
  - `systemctl restart nginx`
- nginx服务重加载
  - `systemctl reload nginx`

## 添加账户
下记为 `proxyuser` ，用于SSH访问(不建议使用root直接访问SSH)，并建议配置使用证书访问方便shell脚本直接启动。该段内容不是重点不做赘述。


# 家庭主机部署

## 添加启动脚本

- ssh -i SSH私钥证书 -R 反向端口转发 2222端口转发本地8080端口
  - `ssh -vnNt -i ~/.ssh/id_rsa -R 2222:localhost:8080 proxyuser@<server_ip> > sshproxy.log 2>&1 &`
- 添加ssh客户端连接配置信息防止sshl连接时间过长自动断开，修改 `/etc/ssh/ssh_config` 文件，添加下述内容。
  - `ServerAliveInterval 60`
  - `ServerAliveCountMax 86400`
- 后重启SSH服务
  - `systemctl restart sshd`
