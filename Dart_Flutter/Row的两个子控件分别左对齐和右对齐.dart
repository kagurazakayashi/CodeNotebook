// 方式一：使用spaceBetween对齐方式

new Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    new Text("left"),
    new Text("right")
  ]
);


// 方式二：中间使用Expanded自动扩展

Row(
  children: <Widget>[
    FlutterLogo(),//左对齐
    Expanded(child: SizedBox()),//自动扩展挤压
    FlutterLogo(),//右对齐
  ],
);


// 方式三：使用Spacer自动填充

Row(
  children: <Widget>[
    FlutterLogo(),
    Spacer(),
    FlutterLogo(),
  ],
);


// 方式四：使用Flexible

Row(
  children: <Widget>[
    FlutterLogo(),
    Flexible(fit: FlexFit.tight, child: SizedBox()),
    FlutterLogo(),
  ],
);


// http://findsrc.com/flutter/detail/8766