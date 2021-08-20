import 'package:flutter/material.dart';

ButtonStyle setButtonStyle(
    {Color? fgfocused,
    Color? fgpressed,
    Color? fgdef,
    Color? bgfocused,
    Color? overlayColorPressed,
    Color? overlayColor,
    double? elevation,
    EdgeInsets? padding,
    Size? minimumSize,
    BorderSide? side,
    StadiumBorder? shape}) {
  return ButtonStyle(
    //设置按钮上字体与图标的颜色
    foregroundColor: MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.focused) &&
            !states.contains(MaterialState.pressed)) {
          //获取焦点时的颜色
          return fgfocused;
        } else if (states.contains(MaterialState.pressed)) {
          //按下时的颜色
          return fgpressed;
        }
        //默认状态使用灰色
        return fgdef;
      },
    ),
    //背景颜色
    backgroundColor: MaterialStateProperty.resolveWith((states) {
      //设置按下时的背景颜色
      if (states.contains(MaterialState.pressed)) {
        return bgfocused;
      }
      //默认不使用背景颜色
      return null;
    }),
    //设置水波纹颜色
    overlayColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.pressed)) {
        return overlayColorPressed;
      }
      return overlayColor;
    }),
    //设置阴影  不适用于TextButton
    elevation: MaterialStateProperty.all(elevation),
    //设置按钮内边距
    padding: MaterialStateProperty.all(padding),
    //设置按钮的大小
    minimumSize: MaterialStateProperty.all(minimumSize),

    //设置边框
    side: MaterialStateProperty.all(side),
    //外边框装饰 会覆盖 side 配置的样式
    shape: MaterialStateProperty.all(shape),
  );
}
