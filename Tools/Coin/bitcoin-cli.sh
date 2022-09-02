datadir="-datadir=/volume2/coin/bitcoin/data"
rpcpassword="" && walletpassword=""
bitlogin="-rpcconnect=127.0.0.1 -rpcport=30011 -rpcuser=yashi -rpcpassword=$rpcpassword"

# 用密码解锁钱包  1073741824 秒超时是最大值
./bitcoin-cli $datadir $bitlogin walletpassphrase $walletpassword 1073741824

# 一般信息
./bitcoin-cli $datadir $bitlogin -getinfo

# 网络状态
./bitcoin-cli $datadir $bitlogin getnetworkinfo

# 钱包状态
./bitcoin-cli $datadir $bitlogin getwalletinfo

# 查看网络节点
./bitcoin-cli $datadir $bitlogin getpeerinfo

# 查看区块链信息：如同步进度
./bitcoin-cli $datadir $bitlogin getblockchaininfo

# 查看和解码交易
./bitcoin-cli $datadir $bitlogin getrawtransaction 交易ID
./bitcoin-cli $datadir $bitlogin decoderawtransaction 上个命令输出的数据

# 探索区块
./bitcoin-cli $datadir $bitlogin getblockhash 区块高度
./bitcoin-cli $datadir $bitlogin getblock 上个命令获取的区块哈希

# 关闭服务
./bitcoin-cli $datadir $bitlogin stop

# 生成一个新地址
./bitcoin-cli $datadir $bitlogin getnewaddress "yashi"

# 获取地址信息
./bitcoin-cli $datadir $bitlogin getaddressinfo "bc1qt0pwc76tepvc9svvuqrlu5glhj2n5mdnq8na2r"

# 获取余额 以bitcoin为单位的余额
./bitcoin-cli $datadir $bitlogin getbalance "*" 1 true

# 加密钱包
./bitcoin-cli $datadir $bitlogin encryptwallet $walletpassword

# https://blog.csdn.net/sitebus/article/details/103405159