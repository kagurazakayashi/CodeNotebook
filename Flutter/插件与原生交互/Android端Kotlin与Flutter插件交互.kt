package moe.yashi.yawebsocket.ya_websocket

import android.os.Handler
import android.os.Looper
import android.util.Log
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import java.util.*

class YaWebsocketPlugin : FlutterPlugin, MethodCallHandler, EventChannel.StreamHandler {
    // 接收来自 Flutter 的通知，可以回复该通知
    private lateinit var _methodChannel: MethodChannel
    // 可以随时发送的通知
    private lateinit var _eventChannel: EventChannel
    private var _eventChannelSink: EventChannel.EventSink? = null

    // 注册这些通知的名称
    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        _methodChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "ya_websocket_m")
        _methodChannel.setMethodCallHandler(this)
        _eventChannel = EventChannel(flutterPluginBinding.binaryMessenger,"ya_websocket_e")
        _eventChannel.setStreamHandler(this)
    }

    // 接收 Flutter 的通知，send 是通知名称
    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "send" -> send(call, result)
            else -> result.notImplemented()
        }
    }

    // 根据通知名称执行具体的代码
    private fun send(@NonNull call: MethodCall, @NonNull result: Result) {
        var returnVal = HashMap<String, String>()
        returnVal["status"] = "0"
        // 将数据返回给 Flutter ，可以是 Map 也可以是 String 等其他。
        result.success(returnVal)
    }

    // 在其他地方可以直接返回数据的 eventChannel 通知
    fun onOpen() {
        var returnVal = HashMap<String, String>()
        returnVal["type"] = "onOpen"
        // 将数据返回给 Flutter ，可以是 Map 也可以是 String 等其他。
        // 注意用 EventChannel.EventSink 不是 EventChannel 类型。
        _eventChannelSink.success(returnVal)
    }
}