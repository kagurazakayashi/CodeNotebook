# Windows SSH
`notepad C:\Users\yashi\.ssh\config`
```
Host github.com
  ProxyCommand "C:\Program Files\Git\mingw64\bin\connect.exe" -S 127.0.0.1:1080 %h %p

Host gitlab.com
  ProxyCommand "C:\Program Files\Git\mingw64\bin\connect.exe" -S 127.0.0.1:1080 %h %p
```
- `-S` 指是 socks 代理，默认是 socks5, 如果要使用 HTTP 代理，就写 `-H`
- `%h %p` 意思是 Host 和 Port

# macOS SSH
`vim ~/.ssh/config`
```
Host github.com
   HostName github.com
   User git
   ProxyCommand nc -v -x 127.0.0.1:6153 %h %p

Host gitlab.com
   ProxyCommand nc -v -x 127.0.0.1:6153 %h %p
```
- `ProxyCommand socat - PROXY:127.0.0.1:%h:%p,proxyport=8080` # 走 HTTP 代理

# 全局 HTTP

## 走 HTTP 代理
```
git config --global http.proxy "http://127.0.0.1:8080"
git config --global https.proxy "http://127.0.0.1:8080"
```

## 走 socks5 代理（如 Shadowsocks）
```
git config --global http.proxy "socks5://127.0.0.1:1080"
git config --global https.proxy "socks5://127.0.0.1:1080"
```

## 取消设置
```
git config --global --unset http.proxy
git config --global --unset https.proxy
```