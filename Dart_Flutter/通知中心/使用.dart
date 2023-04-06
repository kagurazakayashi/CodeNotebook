// 判断是否有通知
if (NotificationCenter.instance.postNameMap.containsKey(nkey)) {
}

// 添加通知
NotificationCenter.instance.addObserver(nkey, (object) {
    // 执行的方法
});

// 移除通知
NotificationCenter.instance.removeNotification(nkey);

// 发送通知
NotificationCenter.instance.postNotification(nkey, {key, value});
