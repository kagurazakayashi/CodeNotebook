<?php
// Windows
// extension=php_igbinary.dll
// extension=php_redis.dll
// Linux
// extension=redis.so

$redis = new Redis();
$redis->connect("127.0.0.1", 6379);
$redis->auth("password");
$redis->select(2);
$redis->keys("session_*");
$redis->set("key","val");
$redis->setex("key",60,"val");
$redis->expire("key",60);
if ($redis->exists("key")) {
    echo $redis->get("key");
    $redis->del("key");
}
$redis->close();
?>