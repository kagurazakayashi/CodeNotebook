// go get github.com/go-redis/redis/v8
import (
    "context"
    "github.com/go-redis/redis/v8"
)

var ctx = context.Background()

func ExampleClient() {
    rdb := redis.NewClient(&redis.Options{
        Addr:     "localhost:6379",
        Password: "", // 密码
        DB:       0,  // 库
    })

    err := rdb.Set(ctx, "key", "value", 0).Err()
    if err != nil {
        panic(err)
    }

    val, err := rdb.Get(ctx, "key").Result()
    if err != nil {
        panic(err)
    }
    fmt.Println("key", val)

    val2, err := rdb.Get(ctx, "key2").Result()
    if err == redis.Nil {
        fmt.Println("key2 does not exist")
    } else if err != nil {
        panic(err)
    } else {
        fmt.Println("key2", val2)
    }
    // Output: key value
    // key2 does not exist


	// SET key value EX 10 NX
	set, err := rdb.SetNX(ctx, "key", "value", 10*time.Second).Result()

	// SET key value keepttl NX
	set, err := rdb.SetNX(ctx, "key", "value", redis.KeepTTL).Result()

	// SORT list LIMIT 0 2 ASC
	vals, err := rdb.Sort(ctx, "list", &redis.Sort{Offset: 0, Count: 2, Order: "ASC"}).Result()

	// ZRANGEBYSCORE zset -inf +inf WITHSCORES LIMIT 0 2
	vals, err := rdb.ZRangeByScoreWithScores(ctx, "zset", &redis.ZRangeBy{
		Min: "-inf",
		Max: "+inf",
		Offset: 0,
		Count: 2,
	}).Result()

	// ZINTERSTORE out 2 zset1 zset2 WEIGHTS 2 3 AGGREGATE SUM
	vals, err := rdb.ZInterStore(ctx, "out", &redis.ZStore{
		Keys: []string{"zset1", "zset2"},
		Weights: []int64{2, 3}
	}).Result()

	// EVAL "return {KEYS[1],ARGV[1]}" 1 "key" "hello"
	vals, err := rdb.Eval(ctx, "return {KEYS[1],ARGV[1]}", []string{"key"}, "hello").Result()

	// custom command
	res, err := rdb.Do(ctx, "set", "key", "value").Result()
}

// set/get示例
func redisExample() {
	err := rdb.Set("score", 100, 0).Err()
	if err != nil {
		fmt.Printf("set score failed, err:%v\n", err)
		return
	}

	val, err := rdb.Get("score").Result()
	if err != nil {
		fmt.Printf("get score failed, err:%v\n", err)
		return
	}
	fmt.Println("score", val)

	val2, err := rdb.Get("name").Result()
	if err == redis.Nil {
		fmt.Println("name does not exist")
	} else if err != nil {
		fmt.Printf("get name failed, err:%v\n", err)
		return
	} else {
		fmt.Println("name", val2)
	}
}

// zset示例
func redisExample2() {
	zsetKey := "language_rank"
	languages := []redis.Z{
		redis.Z{Score: 90.0, Member: "Golang"},
		redis.Z{Score: 98.0, Member: "Java"},
		redis.Z{Score: 95.0, Member: "Python"},
		redis.Z{Score: 97.0, Member: "JavaScript"},
		redis.Z{Score: 99.0, Member: "C/C++"},
	}
	// ZADD
	num, err := rdb.ZAdd(zsetKey, languages...).Result()
	if err != nil {
		fmt.Printf("zadd failed, err:%v\n", err)
		return
	}
	fmt.Printf("zadd %d succ.\n", num)

	// 把Golang的分数加10
	newScore, err := rdb.ZIncrBy(zsetKey, 10.0, "Golang").Result()
	if err != nil {
		fmt.Printf("zincrby failed, err:%v\n", err)
		return
	}
	fmt.Printf("Golang's score is %f now.\n", newScore)

	// 取分数最高的3个
	ret, err := rdb.ZRevRangeWithScores(zsetKey, 0, 2).Result()
	if err != nil {
		fmt.Printf("zrevrange failed, err:%v\n", err)
		return
	}
	for _, z := range ret {
		fmt.Println(z.Member, z.Score)
	}

	// 取95~100分的
	op := redis.ZRangeBy{
		Min: "95",
		Max: "100",
	}
	ret, err = rdb.ZRangeByScoreWithScores(zsetKey, op).Result()
	if err != nil {
		fmt.Printf("zrangebyscore failed, err:%v\n", err)
		return
	}
	for _, z := range ret {
		fmt.Println(z.Member, z.Score)
	}
}

func redisExample3() {
	// 根据前缀获取Key
	keys, err := rdb.Keys(ctx, "prefix*").Result()

	// 执行自定义命令
	res, err := rdb.Do(ctx, "set", "key", "value").Result()

	// 按通配符删除key
	// 当通配符匹配的key的数量不多时，可以使用Keys()得到所有的key在使用Del命令删除。 如果key的数量非常多的时候，我们可以搭配使用Scan命令和Del命令完成删除。
	ctx := context.Background()
	iter := rdb.Scan(ctx, 0, "prefix*", 0).Iterator()
	for iter.Next(ctx) {
		err := rdb.Del(ctx, iter.Val()).Err()
		if err != nil {
			panic(err)
		}
	}
	if err := iter.Err(); err != nil {
		panic(err)
	}

	// Pipeline 主要是一种网络优化。它本质上意味着客户端缓冲一堆命令并一次性将它们发送到服务器。这些命令不能保证在事务中执行。这样做的好处是节省了每个命令的网络往返时间（RTT）。
	pipe := rdb.Pipeline()
	incr := pipe.Incr("pipeline_counter")
	pipe.Expire("pipeline_counter", time.Hour)
	_, err := pipe.Exec()
	fmt.Println(incr.Val(), err)
	// 上面的代码相当于将以下两个命令一次发给redis server端执行，与不使用Pipeline相比能减少一次RTT。
	// INCR pipeline_counter
	// EXPIRE pipeline_counts 3600
	// 也可以使用Pipelined：
	var incr *redis.IntCmd
	_, err := rdb.Pipelined(func(pipe redis.Pipeliner) error {
		incr = pipe.Incr("pipelined_counter")
		pipe.Expire("pipelined_counter", time.Hour)
		return nil
	})
	fmt.Println(incr.Val(), err)
}

// https://www.liwenzhou.com/posts/Go/go_redis/