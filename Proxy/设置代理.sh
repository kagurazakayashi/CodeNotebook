# 设置代理 Windows BAT
set http_proxy=http://127.0.0.1:23333
set https_proxy=%http_proxy%
set ftp_proxy=%http_proxy%
set rsync_proxy=%http_proxy%
set ssh_proxy="ProxyCommand=nc -X connect -x 127.0.0.1:23333 %h %p"
set all_proxy=%http_proxy%
set no_proxy=localhost,127.0.0.1,::1,192.168.1.1
set HTTP_PROXY=%http_proxy%
set HTTPS_PROXY=%http_proxy%
set FTP_PROXY=%http_proxy%
set RSYNC_PROXY=%http_proxy%
set SSH_PROXY=%ssh_proxy%
set ALL_PROXY=%http_proxy%
set NO_PROXY=%no_proxy%

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

# 设置代理 NPM
npm config set proxy http://127.0.0.1:1080
npm config set https-proxy http://127.0.0.1:1080
npm config delete proxy
npm config delete https-proxy
