//参考：AlertDialog提示框.dart，initStste类初始化方法.dart，Scaffold_MD布局结构.dart，Widget外层框架.dart，方法接受传值.dart，获得窗口尺寸.dart

import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final windowWidth = MediaQueryData.fromWindow(window).size.width;
  final windowHeight = MediaQueryData.fromWindow(window).size.height;
  final windowtopbar = MediaQueryData.fromWindow(window).padding.top;

  final dataarr = ["AAA", "BBB", "CCC"];

  @override
  void initState() {
    print(MediaQueryData.fromWindow(window));
    super.initState();
  }

  void displaywindow(BuildContext context) {
    List<Widget> actions = [
      FlatButton(
        onPressed: (){
          print("OK");
          Navigator.pop(context);
        },
        child: new Text("OK!"),
      ),
      FlatButton(
        onPressed: (){
          print("NO");
          Navigator.pop(context);
        },
        child: new Text("NO!"),
      )
    ];

    showDialog <void> (
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Text("window"),
          actions: actions,
          content: Text(MediaQueryData.fromWindow(window).toString()),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            // height: windowtopbar,
          ),
          Container(
            height: windowHeight - windowtopbar - kToolbarHeight,
            // color: Colors.red,
            child: _buildSuggestions(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          displaywindow(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: dataarr.length + (dataarr.length - 1),
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          return _buildRow(dataarr[index]);
        });
  }

  Widget _buildRow(String suggestions) {
    return Row(
      children: <Widget>[
        Icon(Icons.flip_to_back),
        SizedBox(
          width: 10.0,
        ),
        Text(suggestions),
      ],
    );
  }
}
