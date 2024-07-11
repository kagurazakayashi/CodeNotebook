# 全局 HTTP

## 走 HTTP 代理
```bash
git config --global http.proxy "http://127.0.0.1:8080"
git config --global https.proxy "http://127.0.0.1:8080"
```

## 走 socks5 代理（如 Shadowsocks）
```bash
git config --global http.proxy "socks5://127.0.0.1:1080"
git config --global https.proxy "socks5://127.0.0.1:1080"
```

## 取消设置
```bash
git config --global --unset http.proxy
git config --global --unset https.proxy
```

# 设置代理 Windows BAT

SET http_proxy=http://127.0.0.1:23333
SET https_proxy=%http_proxy%
SET ftp_proxy=%http_proxy%
SET rsync_proxy=%http_proxy%
SET ssh_proxy="ProxyCommand=nc -X connect -x 127.0.0.1:23333 %h %p"
SET all_proxy=%http_proxy%
SET no_proxy=localhost,127.0.0.1,::1,192.168.1.1
SET HTTP_PROXY=%http_proxy%
SET HTTPS_PROXY=%http_proxy%
SET FTP_PROXY=%http_proxy%
SET RSYNC_PROXY=%http_proxy%
SET SSH_PROXY=%ssh_proxy%
SET ALL_PROXY=%http_proxy%
SET NO_PROXY=%no_proxy%

# 设置代理 Linux macOS BASH

export http_proxy=http://127.0.0.1:23333
export https_proxy=$http_proxy
export ftp_proxy=$http_proxy
export rsync_proxy=$http_proxy
export ssh_proxy='ProxyCommand=nc -X connect -x 127.0.0.1:23333 %h %p'
export all_proxy=$http_proxy
export no_proxy=localhost,::1,`echo 127.0.0.{0..255}|tr ' ' ','`,`echo 192.168.{0..255}.{0..255}|tr ' ' ','`
export HTTP_PROXY=$http_proxy
export HTTPS_PROXY=$http_proxy
export FTP_PROXY=$http_proxy
export RSYNC_PROXY=$http_proxy
export SSH_PROXY=$ssh_proxy
export ALL_PROXY=$http_proxy
export NO_PROXY=$no_proxy
