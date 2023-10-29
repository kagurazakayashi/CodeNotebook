# npm代理
npm config set https-proxy=http://用户名:密码@代理Host:端口号/
npm config set proxy=http://用户名:密码@代理Host:端口号/

npm config set https-proxy=http://127.0.0.1:1080/
npm config set proxy=http://127.0.0.1:1080/

npm config delete proxy
npm config delete https-proxy

# 默认源
npm config set registry https://registry.npmjs.org
# 淘宝源
npm config set registry http://registry.npmmirror.com
