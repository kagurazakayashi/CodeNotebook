#import <Flutter/Flutter.h>

@interface EspblufiforflutterPlugin : NSObject<FlutterPlugin,FlutterStreamHandler>
// 接收来自 Flutter 的通知，可以回复该通知
@property (nonatomic) FlutterMethodChannel* methodChannel;
// 可以随时发送的通知
@property (nonatomic) FlutterEventChannel* eventChannel;
@property (nonatomic) FlutterEventSink eventChannelSink;
@end
