# BASH
set http_proxy=http://127.0.0.1:1081
set https_proxy=http://127.0.0.1:1081

# NPM
npm config set proxy http://127.0.0.1:1081
npm confit set https-proxy http://127.0.0.1:1081
npm config delete proxy
npm config delete https-proxy
