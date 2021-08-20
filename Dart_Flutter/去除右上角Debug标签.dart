//main.dart
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return isIOS
        ? CupertinoApp(
            debugShowCheckedModeBanner: false, // iOS 设置这一属性
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false, // Android 设置这一属性
          );
  }
}