@override
Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
                title: Text('WillPopScope'),
                centerTitle: true,
            ),
        ),
        onWillPop: () => _willPop(),
    );
}
Future<bool> _willPop () { //返回值必须是Future<bool>
    Navigator.pop(context);
    return Future.value(false); 
}

// https://www.jianshu.com/p/6972ef549a74