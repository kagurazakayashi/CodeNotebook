// 按钮_带图标和文字的按钮

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yiibai.com',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
            title: Text("Flutter ElevatedButton Example")
        ),
        body: Center (
            child: ElevatedButton.icon (
              icon: Icon(Icons.settings),
              label: Text("Settings"),
              onPressed: () {},
            )
        )
    );
  }
}

// https://www.yiibai.com/flutter/flutter-elevatedbutton.html
