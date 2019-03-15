npm config set proxy=http://127.0.0.1:1080 && npm config set https-proxy=http://127.0.0.1:1080

npm config delete proxy && npm config delete https-proxy

npm install -g npm-check && npm-check -u -g
