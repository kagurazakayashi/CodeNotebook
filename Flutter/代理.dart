import 'dart:async';
import 'package:flutter/services.dart';

// 创建抽象类
abstract class YaWebsocketDelegate {
    yaWebsocketDelegateOnOpen(String httpStatus, String httpStatusMessage, String? tag);
    yaWebsocketDelegateOnConnecting(String? tag);
    yaWebsocketDelegateOnMessage(String message, String? tag);
    yaWebsocketDelegateOnClose(String code, String reason, String remote, String? tag);
    yaWebsocketDelegateOnError(String localizedMessage, String? message, String? tag);
}

// 普通类里调用
class YaWebsocket {
    YaWebsocketDelegate? delegate;

    eventChannelData() {
        delegate!.yaWebsocketDelegateOnMessage(arguments["message"], arguments["tag"] ?? null);
        break;
    }
}

// 外面的类里实现
import 'package:ya_websocket/main.dart';
// 用 implements 抽象类名称
class _MyAppState extends State<MyApp> implements YaWebsocketDelegate {
    late YaWebsocket _websocket;

    // 初始化中设置为 implements 的自己类
    @override
    void initState() {
        _websocket = YaWebsocket();
        _websocket.delegate = this;
    }

    // 逐个实现抽象类中规定的所有函数
    @override
    yaWebsocketDelegateOnOpen(String httpStatus, String httpStatusMessage, String? tag) {
        setState(() {
            print("OnOpen");
        });
    }
}