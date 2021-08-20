import 'package:flutter/material.dart';

class GridvPage extends StatelessWidget {
  final String title;
  const GridvPage({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyHomePage(title: title),
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
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
