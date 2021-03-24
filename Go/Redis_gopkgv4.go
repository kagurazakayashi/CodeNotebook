// go get gopkg.in/redis.v4
import "gopkg.in/redis.v4"
var r *redis.Client
r = createClient()
// 创建 redis 客户端
func createClient() *redis.Client {
    client := redis.NewClient(&redis.Options{
        Addr:     "localhost:6379",
        Password: "",
        DB:       0,
		PoolSize: 5, // 我们可以在初始化 redis 客户端时自行设置连接池的大小
    })

    // 通过 cient.Ping() 来检查是否成功连接到了 redis 服务器
    pong, err := client.Ping().Result()
    fmt.Println(pong, err)

    return client
}
func string_c() {
	r.set(key, value) // 给数据库中名称为key的string赋予值value
	r.get(key) // 返回数据库中名称为key的string的value
	r.getset(key, value) // 给名称为key的string赋予上一次的value
	r.mget(key1, key2,…, key N) // 返回库中多个string的value
	r.setnx(key, value) // 添加string，名称为key，值为value
	r.setex(key, time, value) // 向库中添加string，设定过期时间time
	r.mset(key N, value N) // 批量设置多个string的值
	r.msetnx(key N, value N) // 如果所有名称为key i的string都不存在
	r.incr(key) // 名称为key的string增1操作
	r.incrby(key, integer) // 名称为key的string增加integer
	r.decr(key) // 名称为key的string减1操作
	r.decrby(key, integer) // 名称为key的string减少integer
	r.append(key, value) // 名称为key的string的值附加value
	r.substr(key, start, end) // 返回名称为key的string的value的子串
}
func list_c() {
	r.rpush(key, value) // 在名称为key的list尾添加一个值为value的元素
	r.lpush(key, value) // 在名称为key的list头添加一个值为value的 元素
	r.llen(key) // 返回名称为key的list的长度
	r.lrange(key, start, end) // 返回名称为key的list中start至end之间的元素
	r.ltrim(key, start, end) // 截取名称为key的list
	r.lindex(key, index) // 返回名称为key的list中index位置的元素
	r.lset(key, index, value) // 给名称为key的list中index位置的元素赋值
	r.lrem(key, count, value) // 删除count个key的list中值为value的元素
	r.lpop(key) // 返回并删除名称为key的list中的首元素
	r.rpop(key) // 返回并删除名称为key的list中的尾元素
	r.blpop(key1, key2,… key N, timeout) // lpop命令的block版本。
	r.brpop(key1, key2,… key N, timeout) // rpop的block版本。
	r.rpoplpush(srckey, dstkey) // 返回并删除名称为srckey的list的尾元素，并将该元素添加到名称为dstkey的list的头部
}
func set_c() {
	r.sadd(key, member) // 向名称为key的set中添加元素member
	r.srem(key, member)  // 删除名称为key的set中的元素member
	r.spop(key)  // 随机返回并删除名称为key的set中一个元素
	r.smove(srckey, dstkey, member)  // 移到集合元素
	r.scard(key)  // 返回名称为key的set的基数
	r.sismember(key, member)  // member是否是名称为key的set的元素
	r.sinter(key1, key2,…key N)  // 求交集
	r.sinterstore(dstkey, (keys))  // 求交集并将交集保存到dstkey的集合
	r.sunion(key1, (keys))  // 求并集
	r.sunionstore(dstkey, (keys))  // 求并集并将并集保存到dstkey的集合
	r.sdiff(key1, (keys))  // 求差集
	r.sdiffstore(dstkey, (keys))  // 求差集并将差集保存到dstkey的集合
	r.smembers(key)  // 返回名称为key的set的所有元素
	r.srandmember(key)  // 随机返回名称为key的set的一个元素
}
func hash_c() {
	r.hset(key, field, value) // 向名称为key的hash中添加元素field
	r.hget(key, field) // 返回名称为key的hash中field对应的value
	r.hmget(key, (fields)) // 返回名称为key的hash中field i对应的value
	r.hmset(key, (fields)) // 向名称为key的hash中添加元素field 
	r.hincrby(key, field, integer) // 将名称为key的hash中field的value增加integer
	r.hexists(key, field) // 名称为key的hash中是否存在键为field的域
	r.hdel(key, field) // 删除名称为key的hash中键为field的域
	r.hlen(key) // 返回名称为key的hash中元素个数
	r.hkeys(key) // 返回名称为key的hash中所有键
	r.hvals(key) // 返回名称为key的hash中所有键对应的value
	r.hgetall(key) // 返回名称为key的hash中所有的键（field）及其对应的value
}
// https://segmentfault.com/a/1190000007078961


//*扫描所有key，每次20条
var cursor uint64
var n int
for {
	var keys []string
	var err error
	//*扫描所有key，每次20条
	keys, cursor, err = client.Scan(cursor, "*", 20).Result()
	if err != nil {
		panic(err)
	}
	n += len(keys)

	fmt.Printf("\nfound %d keys\n", n)
	var value string
	for _, key := range keys {
		value, err = client.Get(key).Result()
		fmt.Printf("%v %v\n", key, value)
	}
	if cursor == 0 {
		break
	}
}
