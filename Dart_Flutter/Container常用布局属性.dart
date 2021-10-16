@override
Widget build(BuildContext context) {
  List aa =['aa','bb','cc',1,2,3,1,5];
  return Container(
    color: Colors.redAccent,
    width: 100,
    child: Column( // 纵向排列
      mainAxisSize: MainAxisSize.max, // max铺满，min适应内容
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 纵向平均分
      crossAxisAlignment: CrossAxisAlignment.center, // 子方向（横向）居中
      children: aa.map((e) {
        return Text(e.toString()); // 根据数组创建多个文字显示
      }).toList(),
    ),
  ),
}