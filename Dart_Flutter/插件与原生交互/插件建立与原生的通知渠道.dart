class YaWebsocket {
    // 向原生发送通知，原生可以回复该通知
    MethodChannel _methodChannel = const MethodChannel('ya_websocket_m');
    // 接收原生随时发送的通知
    EventChannel _eventChannel = EventChannel('ya_websocket_e');

    // 构造方法
    YaWebsocket() {
        // 在构造方法里面设置监听原生随时发送的通知，收到原生发来的通知时，调用 eventChannelData 函数
        _eventChannel.receiveBroadcastStream().listen(eventChannelData);
    }

    // 收到原生随时发来的通知，event 是原生传回来的数据
    eventChannelData(event) {
        print(event);
        // 可以是 Map 也可以是 String 等其他
        Map arguments = event;
        print(arguments);
    }

    // 向原生发送通知，让原生执行某项功能
    Future<Map?> send(String text) async {
        // 可以是 Map 也可以是 String 等其他
        // send 是功能名称
        // await 是等待它执行结束，直接拿到原生的返回值
        final Map? info = await _methodChannel.invokeMethod('send', {'text': text});
        print(info);
        return info;
    }
}