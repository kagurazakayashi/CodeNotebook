package com.example.gh0wew0documentdelivery;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

import android.view.KeyEvent;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
  //通讯名称,回到手机桌面
  private final String CHANNEL = "android/back/desktop";
  //1.是否返回到手机桌面,不退出app
  //2.不做处理,默认不做处理
  private boolean out = false;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
        @Override
        public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
          //通过methodCall可以获取参数和方法名  执行对应的平台业务逻辑即可
          if (methodCall.method.equals("setOut")) {
            //设置 当前flutter页退出到手机桌面
            boolean setOut = setOut();

            if (setOut) {
              result.success(true);
              //调用退出到桌面的 方法
              moveTaskToBack(false);
            } else {
              result.error("设置失败", "欧姆计", null);
            }
          } else if(methodCall.method.equals("cancelOut")) {//设置 当前flutter页不做处理
            boolean cancelOut  = cancelOut();
            if (cancelOut) {
              result.success(true);
            } else {
              result.error("取消失败", "欧姆计", null);
            }
          }
        }
      }
    );
  }

  //是否返回到手机桌面
  private boolean setOut(){
    this.out = true;
    return true;
  }

  //不做处理
  private boolean cancelOut(){
    this.out = false;
    return  true;
  }

  //  返回不退出app
  public boolean onKeyDown(int keyCode, KeyEvent event) {
    if (keyCode == KeyEvent.KEYCODE_BACK && out) {
      moveTaskToBack(true);
      return true;
    }
    return super.onKeyDown(keyCode, event);
  }

  @Override
  public void onBackPressed() {
    if(out){
      moveTaskToBack(false);
    }
    super.onBackPressed();
  }
}