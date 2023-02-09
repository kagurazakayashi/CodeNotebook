#import "EspblufiforflutterPlugin.h"

@implementation EspblufiforflutterPlugin

// 註冊這些通知的名稱
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    EspblufiforflutterPlugin* instance = [[EspblufiforflutterPlugin alloc] init];
    // 接收來自 Flutter 的通知，可以回覆該通知
    instance.methodChannel = [FlutterMethodChannel methodChannelWithName:@"flutter_to_native" binaryMessenger:[registrar messenger]];
    [registrar addMethodCallDelegate:instance channel:instance.methodChannel];
    // 可以隨時傳送的通知
    instance.eventChannel = [FlutterEventChannel eventChannelWithName:@"native_to_flutter" binaryMessenger:[registrar messenger]];
    [instance.eventChannel setStreamHandler:instance];
}

// 接收 Flutter 的通知，call.method 是通知名稱
- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString *method = call.method;
    if ([@"getPlatformVersion" isEqualToString:method]) {
        // 【同步】將資料返回給 Flutter ，可以是 Map 也可以是 String 等其他。
        NSDictionary* returnVal = [NSDictionary dictionaryWithObjectsAndKeys:@"getPlatformVersion",@"k",@"result",@"f",[[UIDevice currentDevice] systemVersion],@"v", nil];
        result(returnVal);
        [self pushPlatformVersion];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

// 在其他地方可以直接返回資料的 eventChannel 通知
- (void)pushPlatformVersion{
    NSDictionary* returnVal = [NSDictionary dictionaryWithObjectsAndKeys:@"getPlatformVersion",@"k",@"event",@"f",[[UIDevice currentDevice] systemVersion],@"v", nil];
    // 【非同步】將資料返回給 Flutter ，可以是 Map 也可以是 String 等其他。
    NSLog(@"将数据返回给 Flutter");
    self.eventChannelSink(returnVal);
}

// MARK: - FlutterStreamHandler
- (FlutterError * _Nullable)onCancelWithArguments:(id _Nullable)arguments { 
    self.eventChannelSink = nil;
    return nil;
}

- (FlutterError * _Nullable)onListenWithArguments:(id _Nullable)arguments eventSink:(nonnull FlutterEventSink)events { 
    self.eventChannelSink = events;
    return nil;
}

@end
