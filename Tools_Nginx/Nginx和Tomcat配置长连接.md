# Nginx 支持 keep alive 长连接
```
http {
    keepalive_timeout  120s 120s;
    keepalive_requests 10000;
}
```
## 保持和server的长连接、反代支持长连接
```
http {
    upstream  BACKEND {
        server   192.168.0.1：8080  weight=1 max_fails=2 fail_timeout=30s;
        server   192.168.0.2：8080  weight=1 max_fails=2 fail_timeout=30s;

        keepalive 300;        // 这个很重要！
    }

    server {
        listen 8080 default_server;
        server_name "";

        location /  {
            proxy_pass http://BACKEND;
            proxy_set_header Host  $Host;
            proxy_set_header x-forwarded-for $remote_addr;
            proxy_set_header X-Real-IP $remote_addr;
            add_header Cache-Control no-store;
            add_header Pragma  no-cache;

            proxy_http_version 1.1;                    // 这两个最好也设置
            proxy_set_header Connection "";

            client_max_body_size  3072k;
            client_body_buffer_size 128k;
        }
    }
}
```
[支持keep alive长连接](https://skyao.gitbooks.io/learning-nginx/content/documentation/keep_alive.html)

# Tomcat
maxKeepAliveRequests="100"  //请求个数超过这个数，强制关闭掉socket链接