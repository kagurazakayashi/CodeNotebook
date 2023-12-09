# 一般信息
./bitcoin-cli -datadir=/mnt/d/btc/BitcoinData -rpcconnect=127.0.0.1 -rpcport=8332 -rpcuser=yashi -rpcpassword=$rpcpassword -getinfo

# 网络状态
./bitcoin-cli -datadir=/mnt/d/btc/BitcoinData -rpcconnect=127.0.0.1 -rpcport=8332 -rpcuser=yashi -rpcpassword=$rpcpassword getnetworkinfo

# 钱包状态
./bitcoin-cli -datadir=/mnt/d/btc/BitcoinData -rpcconnect=127.0.0.1 -rpcport=8332 -rpcuser=yashi -rpcpassword=$rpcpassword getwalletinfo

# 查看网络节点
./bitcoin-cli -datadir=/mnt/d/btc/BitcoinData -rpcconnect=127.0.0.1 -rpcport=8332 -rpcuser=yashi -rpcpassword=$rpcpassword getpeerinfo

# 查看区块链信息：如同步进度
./bitcoin-cli -datadir=/mnt/d/btc/BitcoinData -rpcconnect=127.0.0.1 -rpcport=8332 -rpcuser=yashi -rpcpassword=$rpcpassword getblockchaininfo

# 查看和解码交易
./bitcoin-cli -datadir=/mnt/d/btc/BitcoinData -rpcconnect=127.0.0.1 -rpcport=8332 -rpcuser=yashi -rpcpassword=$rpcpassword getrawtransaction 交易ID
./bitcoin-cli -datadir=/mnt/d/btc/BitcoinData -rpcconnect=127.0.0.1 -rpcport=8332 -rpcuser=yashi -rpcpassword=$rpcpassword decoderawtransaction 上个命令输出的数据

# 探索区块
./bitcoin-cli -datadir=/mnt/d/btc/BitcoinData -rpcconnect=127.0.0.1 -rpcport=8332 -rpcuser=yashi -rpcpassword=$rpcpassword getblockhash 区块高度
./bitcoin-cli -datadir=/mnt/d/btc/BitcoinData -rpcconnect=127.0.0.1 -rpcport=8332 -rpcuser=yashi -rpcpassword=$rpcpassword getblock 上个命令获取的区块哈希

# 关闭服务
./bitcoin-cli -datadir=/mnt/d/btc/BitcoinData -rpcconnect=127.0.0.1 -rpcport=8332 -rpcuser=yashi -rpcpassword=$rpcpassword stop

# 生成一个新地址
./bitcoin-cli -datadir=/mnt/d/btc/BitcoinData -rpcconnect=127.0.0.1 -rpcport=8332 -rpcuser=yashi -rpcpassword=$rpcpassword getnewaddress "yashi"

# 获取地址信息
./bitcoin-cli -datadir=/mnt/d/btc/BitcoinData -rpcconnect=127.0.0.1 -rpcport=8332 -rpcuser=yashi -rpcpassword=$rpcpassword getaddressinfo "bc1qt0pwc76tepvc9svvuqrlu5glhj2n5mdnq8na2r"

# 用密码解锁钱包  1073741824 秒超时是最大值
./bitcoin-cli -datadir=/mnt/d/btc/BitcoinData -rpcconnect=127.0.0.1 -rpcport=8332 -rpcuser=yashi -rpcpassword=$rpcpassword walletpassphrase $walletpassword 1073741824

# 获取余额 以bitcoin为单位的余额
./bitcoin-cli -datadir=/mnt/d/btc/BitcoinData -rpcconnect=127.0.0.1 -rpcport=8332 -rpcuser=yashi -rpcpassword=$rpcpassword getbalance "*" 1 true

# 加密钱包
./bitcoin-cli -datadir=/mnt/d/btc/BitcoinData -rpcconnect=127.0.0.1 -rpcport=8332 -rpcuser=yashi -rpcpassword=$rpcpassword encryptwallet $walletpassword
