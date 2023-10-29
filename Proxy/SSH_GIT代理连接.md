# Windows SSH
```bash
choco install mingw64
msys2
pacman -Sy netcat connect-proxy
exit
notepad C:\Users\yashi\.ssh\config
```

```conf
Host github.com
  ProxyCommand "C:\Program Files\Git\mingw64\bin\connect.exe" -S 127.0.0.1:1080 %h %p

Host gitlab.com
  ProxyCommand "C:\Program Files\Git\mingw64\bin\connect.exe" -S 127.0.0.1:1080 %h %p
```
- `-S` 指是 socks 代理，默认是 socks5, 如果要使用 HTTP 代理，就写 `-H`
- `%h %p` 意思是 Host 和 Port

# macOS SSH
```bash
sudo apt install netcat connect-proxy -y   # Linux
brew install netcat connect-proxy -y       # macOS
vim ~/.ssh/config
```

```conf
Host github.com
   HostName ssh.github.com
   User git
   ProxyCommand nc -v -x 127.0.0.1:6153 %h %p

Host gitlab.com
   ProxyCommand nc -v -x 127.0.0.1:6153 %h %p
```
- `ProxyCommand socat - PROXY:127.0.0.1:%h:%p,proxyport=8080` # 走 HTTP 代理
