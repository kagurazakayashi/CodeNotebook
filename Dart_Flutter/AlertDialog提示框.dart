void displaywindow(BuildContext context) {
  List<Widget> actions = [
    FlatButton(
      onPressed: (){
        print("确定了");
        Navigator.pop(context); //关闭提示框
      },
      child: new Text("确定"),
    ),
    FlatButton(
      onPressed: (){
        print("取消了");
        Navigator.pop(context);
      },
      child: new Text("取消"),
    )
  ];

  showDialog <void> (
    context: context,
    builder: (BuildContext context) {
      return new AlertDialog(
        title: Text("问题"),
        actions: actions,
        content: Text(MediaQueryData.fromWindow(window).toString()),
      );
    }
  );
}

/* onPressed: () {
    displaywindow(context);
   }, */
