# Windows BAT
set http_proxy=http://127.0.0.1:1080
set https_proxy=http://127.0.0.1:1080

# Linux macOS BASH
export http_proxy="socks5://127.0.0.1:1080"
export https_proxy="socks5://127.0.0.1:1080"

# NPM
npm config set proxy http://127.0.0.1:1080
npm config set https-proxy http://127.0.0.1:1080
npm config delete proxy
npm config delete https-proxy
