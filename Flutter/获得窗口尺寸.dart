import 'dart:ui';

final mqdwindow = MediaQueryData.fromWindow(window);
final windowWidth = mqdwindow.size.width;
final windowHeight = mqdwindow.size.height;
// 顶部高度
final windowtopbar = mqdwindow.padding.top;

// MediaQueryData(size: Size(360.0, 640.0), devicePixelRatio: 3.0, textScaleFactor: 1.0, padding: EdgeInsets(0.0, 24.0, 0.0, 0.0), viewInsets: EdgeInsets.zero, alwaysUse24HourFormat: false, accessibleNavigation: falsedisableAnimations: falseinvertColors: falseboldText: false)
