class YaWebsocket {
    abstract class YaWebsocketDelegate {
        YaWebsocketDelegateOnData(String? info);
    }
    YaWebsocketDelegate? delegate;

    // 向原生发送通知，原生可以回复该通知
    final MethodChannel _methodChannel = const MethodChannel('flutter_to_native');
    // 接收原生随时发送的通知
    final EventChannel _eventChannel = const EventChannel('native_to_flutter');

    // 构造方法
    YaWebsocket() {
        // 在构造方法里面设置监听原生随时发送的通知，收到原生发来的通知时，调用 eventChannelData 函数
        _eventChannel.receiveBroadcastStream().listen(eventChannelData);
    }

    // 【异步】收到原生随时发来的通知，event 是原生传回来的数据
    eventChannelData(event) {
        if (delegate == null) {
            return;
        }
        // 可以是 Map 也可以是 String 等其他
        if (arguments is Map) {
            print("Flutter 收到原生发来的 Map 通知：$arguments");
        } else if (arguments is String) {
            print("Flutter 收到原生发来的 String 通知：$arguments");
            // 用反代发回 UI 处理
            delegate!.YaWebsocketDelegate(arguments);
        }
        // 直接两边走 Map 处理比较方便
        Map arguments = event;
        if (delegateVersion == null) {
            return;
        }
        switch (arguments["k"]) {
            case "platformVersion":
                delegateVersion!.    espblufiforflutterVersionDelegate(arguments    ["v"]);
                break;
            default:
                break;
        }
    }

    // 向原生发送通知，让原生执行某项功能
    Future<Map?> send(String text) async {
        // 可以是 Map 也可以是 String 等其他
        // 【同步】await 是等待它执行结束，直接拿到原生的返回值
        final Map? info = await _methodChannel.invokeMethod('send', {'text': text});
        print(info);
        return info;
    }
}