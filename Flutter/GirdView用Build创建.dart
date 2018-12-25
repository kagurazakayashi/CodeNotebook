//从每行宽度创建
Widget createGridView() {
  return new GridView.builder(
    padding: const EdgeInsets.all(16.0),
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 50.0,
      mainAxisSpacing: 5.0,
      crossAxisSpacing: 5.0,
      childAspectRatio: 1.0,
    ),
    itemCount: dataarr.length,
    itemBuilder: (context, i) {
      return _buildRow(dataarr[i], i);
    },
  );
}

Widget _buildRow(String suggestions, int number) {
  return Container(
    height: 100,
    width: 100,
    color: Colors.yellow,
    child: Text(suggestions));
}
