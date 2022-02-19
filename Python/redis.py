# 安装 redis 模块
# sudo pip3 install redis
# 或
# sudo easy_install redis
# 或
# sudo python setup.py install

import redis
redisPool: redis.ConnectionPool = redis.ConnectionPool(host='127.0.0.1', port=6379, password='password', db=0)
redisConnect = redis.Redis(connection_pool=redisPool0)


# 存储键值
redisConnect.set('redisKey', 'redisVal')        # 存储键值
redisConnect.set('redisKey', 'redisVal', ex=60) # 存储键值，60秒超时
# ex - 过期时间（秒）
# px - 过期时间（毫秒）
# nx - 如果设置为True，则只有name不存在时，当前set操作才执行
# xx - 如果设置为True，则只有name存在时，当前set操作才执行
redisConnect.setnx('redisKey', 'redisVal') # 设置值，只有name不存在时，执行设置操作（添加）。'redisKey' 不存在，输出为True
redisConnect.setex('redisKey', 5, 'redisVal') # 5秒后，取值就从 'redisVal' 变成 None
redisConnect.psetex('redisKey', 5000, 'redisVal') # 5000毫秒后，取值就从 'redisVal' 变成 None
redisConnect.mget({'redisKey1': 'redisVal1', 'redisKey2': 'redisVal2'}) # 批量设置值
redisConnect.mget(redisKey1='redisVal1', redisKey2='redisVal2') # 批量设置值
redisConnect.append('redisKey', 'redisVal2') # 值后面追加内容

# 取出值
data = redisConnect.get('redisKey') # 取出值
if data != None and len(data) > 0:
    print(data)
print(redisConnect.mget('redisKey1', 'redisKey2')) # 批量取出值
print(redisConnect.mget(['redisKey1', 'redisKey2'])) # 批量取出值


# 设置新值并获取原来的值
print(redisConnect.getset('redisKey', 'redisVal'))
# 字节长度（一个汉字3个字节）
print(redisConnect.strlen('redisKey'))
# 自增
incr(self, 'redisKey', amount=1) # amount 是增多少，当 name 不存在时创建 name = amount
# 自减
decr(self, 'redisKey', amount=1) # amount 是增多少，当 name 不存在时创建 name = amount


# Key 操作
redisConnect.keys() # [b'a3c', b'aBc', b'abc', b'a8c', b'abbc']
redisConnect.keys('*') # 同上
redisConnect.keys('a[A-C1-9]c') # ['a3c', 'aBc', 'a8c']
redisConnect.dbsize() # 5
redisConnect.exists('abc') # 1
redisConnect.delete('a8c') # 1
redisConnect.type('abc') # string
redisConnect.expire('abc', 400) # True  密钥过期秒
redisConnect.ttl('abc') # 295
redisConnect.persist('abc') # True  persist key


# https://www.runoob.com/w3cnote/python-redis-intro.html
# https://www.jianshu.com/p/83ead5c7f11e