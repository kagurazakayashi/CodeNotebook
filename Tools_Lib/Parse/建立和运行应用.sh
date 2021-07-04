# https://docs.parseplatform.org/parse-server/guide/#saving-your-first-object
sh <(curl -fsSL https://raw.githubusercontent.com/parse-community/parse-server/master/bootstrap.sh)
npm install -g mongodb-runner
mongodb-runner start
npm start
