<?php
// Windows
// extension=php_igbinary.dll
// extension=php_redis.dll
// Linux
// extension=redis.so

$redis = new Redis();
$redis->connect("127.0.0.1", 6379); // 连接
$redis->auth("password");           // 密码
$redis->select(2);                  // 库编号
$redis->keys("session_*");          // 取多个 key
$redis->set("key","val");           // 设置数据
$redis->setex("key",60,"val");      // 设置数据并60秒过期
$redis->expire("key",60);           // 重设某个 key 的过期时间
$redis->TTL("key");                 // 查看某个 key 的过期时间 -1 为无限
if ($redis->exists("key")) {        // 某个 key 是否存在
    echo $redis->get("key");        // 获取 key 的内容
    $redis->del("key");             // 删除 key
}
$redis->close();                    // 断开连接
?>