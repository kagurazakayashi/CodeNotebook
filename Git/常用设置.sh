# 查看所有的配置
git config --list --show-origin

# 用户名
git config --global user.name "神楽坂雅詩"
git config --global user.email example@example.com

# GPG签名
git config --global user.signingkey 1F01
git config --global commit.gpgsign true

# 代理服务器
git config --global http.proxy "socks5://127.0.0.1:1080"
git config --global http.sslverify false
git config --global https.proxy "socks5://127.0.0.1:1080"
git config --global https.sslverify false
git config --global ssh.proxy "socks5://127.0.0.1:1080"
git config --global ssh.sslverify false

# 默认文本编辑器
git config --global core.editor code

# 提交时转换为LF，检出时转换为CRLF
git config --global core.autocrlf true
# 提交时转换为LF，检出时不转换
git config --global core.autocrlf input
# 提交检出均不转换
git config --global core.autocrlf false

# 拒绝提交包含混合换行符的文件
git config --global core.safecrlf true
# 允许提交包含混合换行符的文件
git config --global core.safecrlf false
# 提交包含混合换行符的文件时给出警告
git config --global core.safecrlf warn