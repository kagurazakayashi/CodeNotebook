import Flutter
import UIKit
import Starscream

public class flutterPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    
    var eventChannelSink : FlutterEventSink?
    var webSocket : YaWebSocket?
    
    // 注册这些通知的名称
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = flutterPlugin()
        // 接收来自 Flutter 的通知，可以回复该通知
        let methodChannel = FlutterMethodChannel(name: "flutter_to_native", binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(instance, channel: methodChannel)
        // 可以随时发送的通知
        let eventChannel = FlutterEventChannel(name: "native_to_flutter", binaryMessenger: registrar.messenger())
        eventChannel.setStreamHandler(instance)
    }
    
    // 接收 Flutter 的通知，call.method 是通知名称
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        // call.arguments 是通知里的是参数
        switch call.method {
        case "getPlatformVersion":
            // 【同步】将数据返回给 Flutter ，可以是 Map 也可以是 String 等其他。
            let args:[String:String] = call.arguments! as! [String : String]
            returnVal["k"] = "getPlatformVersion"
            returnVal["f"] = "result"
            returnVal["v"] = UIDevice.current.systemVersion
            result(returnVal)
            break
        default:
            result(FlutterMethodNotImplemented)
            break
        }
    }

    // 在其他地方可以直接返回数据的 eventChannel 通知
    public func pushPlatformVersion() {
        DispatchQueue.main.async {
            // 【异步】将数据返回给 Flutter ，可以是 Map 也可以是 String 等其他。
            let args:[String:String] = call.arguments! as! [String : String]
            returnVal["k"] = "getPlatformVersion"
            returnVal["f"] = "event"
            returnVal["v"] = UIDevice.current.systemVersion
            self.eventChannelSink(returnVal)
        }
    }
    
    // MARK: - FlutterStreamHandler

    // onDetachedFromEngine?
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventChannelSink = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventChannelSink = nil
        return nil
    }
}
