//从数据数量创建
Widget createGridView() {
return new GridView.count(
    padding: const EdgeInsets.all(5.0),
    mainAxisSpacing: 5.0,
    crossAxisSpacing: 5.0,
    childAspectRatio: 1.0,
    crossAxisCount: widthcount,
    children: dataarr.map((String nowdata){
      return _buildRow(nowdata, 0);
    }).toList(),
  );
}

Widget _buildRow(String suggestions, int number) {
return Container(
    height: 100,
    width: 100,
    color: Colors.yellow,
    child: Text(suggestions));
}
