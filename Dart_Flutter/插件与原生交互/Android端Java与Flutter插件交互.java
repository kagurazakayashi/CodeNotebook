package moe.uuu.espblufiforflutter;

import androidx.annotation.NonNull;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * flutterPlugin
 */
public class flutterPlugin implements FlutterPlugin, MethodCallHandler, EventChannel.StreamHandler {
    // 接收来自 Flutter 的通知，可以回复该通知
    private MethodChannel methodChannel;
    // 可以随时发送的通知
    private EventChannel eventChannel;
    private EventChannel.EventSink eventChannelSink = null;

    @Override
    // 注册这些通知的名称
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        methodChannel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_to_native");
        methodChannel.setMethodCallHandler(this);
        eventChannel = new EventChannel(flutterPluginBinding.getBinaryMessenger(), "native_to_flutter");
        eventChannel.setStreamHandler(this);
    }

    @Override
    // 接收 Flutter 的通知，call.method 是通知名称
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        String method = call.method;
        // call.arguments 是通知里的是参数
        if (method.equals("getPlatformVersion")) {
            // 【同步】将数据返回给 Flutter ，可以是 Map 也可以是 String 等其他。
            Map<String, String> returnVal = new HashMap<>();
            returnVal.put("k", "getPlatformVersion");
            returnVal.put("f", "result");
            returnVal.put("v", android.os.Build.VERSION.RELEASE);
            result.success(returnVal);
            pushPlatformVersion();
        } else {
            result.notImplemented();
        }
    }

    // 在其他地方可以直接返回数据的 eventChannel 通知
    private void pushPlatformVersion() {
        Map<String, String> returnVal = new HashMap<>();
        returnVal.put("k", "getPlatformVersion");
        returnVal.put("f", "event");
        returnVal.put("v", android.os.Build.VERSION.RELEASE);
        // 【异步】将数据返回给 Flutter ，可以是 Map 也可以是 String 等其他。
        eventChannelSink.success(returnVal);
    }

    @Override
    // eventChannelSink
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        methodChannel.setMethodCallHandler(null);
    }

    @Override
    // eventChannelSink
    public void onListen(Object arguments, EventChannel.EventSink events) {
        eventChannelSink = events;
    }

    @Override
    // eventChannelSink
    public void onCancel(Object arguments) {
        eventChannelSink = null;
    }
}
