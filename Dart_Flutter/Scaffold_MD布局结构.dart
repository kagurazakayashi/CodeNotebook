@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar( //顶部标题栏
      title: Text(widget.title),
    ),
    body: Column( //在垂直方向上排列子widget的列表。
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        //Container( //如果不开启顶部标题栏，需要创建一个占位区。
        //  //Container：一个拥有绘制、定位、调整大小的 widget。
        //  height: windowtopbar,
        //),
        Container(
          //窗口高度 - 顶栏高度 - 顶部标题栏高度（开启顶部标题栏再减）
          height: windowHeight - windowtopbar - kToolbarHeight,
          // color: Colors.red,
          child: _buildSuggestions(), //表格视图
        ),
      ],
    ),
    //一个圆形图标按钮，它悬停在内容之上，以展示应用程序中的主要动作。FloatingActionButton通常用于Scaffold.floatingActionButton字段。.
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        displaywindow(context); // >> AlertDialog提示框.dart
      },
      tooltip: 'Increment',
      child: Icon(Icons.add), //图标
    ),
  );
}

//表格视图
final dataarr = ["AAA", "BBB", "CCC"];
Widget _buildSuggestions() {
  return new ListView.builder(
      //可滚动的列表控件。ListView是最常用的滚动widget，它在滚动方向上一个接一个地显示它的孩子。在纵轴上，孩子们被要求填充ListView。
      padding: const EdgeInsets.all(16.0), //边距
      itemCount: dataarr.length + (dataarr.length - 1), //对象容量
      itemBuilder: (context, i) { //对象内容
        //Divider 一个逻辑1像素厚的水平分割线，两边都有填充
        if (i.isOdd) return new Divider(); //如果是奇数插入一条横线
        final index = i ~/ 2; // ~/ 除以，然后返回整数部分
        return _buildRow(dataarr[index]); //创建行
  });
}
//创建行
Widget _buildRow(String suggestions) {
return Row( //行：[图标][间隔][文字]
  children: <Widget>[
    Icon(Icons.ac_unit), //图标
    SizedBox( //间隔
      width: 10.0,
    ),
    Text(suggestions), //文字
  ],
);
}
