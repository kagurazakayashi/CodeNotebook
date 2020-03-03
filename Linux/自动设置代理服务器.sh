export proxy="http://192.168.50.1:8888"
export http_proxy=$proxy
export https_proxy=$proxy
export ftp_proxy=$proxy
export no_proxy="localhost, 127.0.0.1, ::1"

# 取消
unset http_proxy
unset https_proxy
unset ftp_proxy
unset no_proxy