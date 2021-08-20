import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class AndroidBackTop {
  //初始化通信管道-设置退出到手机桌面
  static const String CHANNEL = "android/back/desktop";

  //设置回退到手机桌面
  static Future<bool> backDeskTop() async {
    final platform = MethodChannel(CHANNEL);
    debugPrint('退出到手机桌面=退出');
    //通知安卓返回,到手机桌面
    try {
      final bool out = await platform.invokeMethod('setOut');
      if (out) {
        debugPrint('设置成功');
      }
    } on PlatformException catch (e) {
      print("-----ERROR-----");
      print(e);
      debugPrint("通信失败(设置回退到安卓手机桌面:设置失败)");
    }
    return Future.value(false);
  }

  //设置不做处理
  static Future<bool> cancelBackDeskTop() async {
    final platform = MethodChannel(CHANNEL);
    debugPrint('退出到手机桌面=不做处理');
    //通知安卓返回,到手机桌面
    try {
      final bool out = await platform.invokeMethod('cancelOut');
      if (out) {
        debugPrint('设置取消成功');
      }
    } on PlatformException catch (e) {
      print("-----ERROR-----");
      print(e);
      debugPrint("通信失败(设置回退到安卓手机桌面:取消失败)");
    }
    return Future.value(false);
  }
}
