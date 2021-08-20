import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertest0/gridv.dart';

final gtpages = [new GridvPage(title:"gridv"), new GridvPage(title:"gridv"), new GridvPage(title:"gridv")];
//表格数据部分
Widget _buildSuggestions(ThemeData theme) {
  return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: dataarr.length + (dataarr.length - 1),
      itemBuilder: (context, i) {
        if (i.isOdd) return new Divider();
        final index = i ~/ 2; // ~/ 返回整数部分
        return _buildRow(dataarr[index], index, theme);
      });
}
//推新窗体
Widget _buildRow(String suggestions, int number, ThemeData theme) {
return RawMaterialButton(
  padding: EdgeInsets.zero,
  splashColor: theme.primaryColor.withOpacity(0.12),
  highlightColor: Colors.transparent,
  onPressed: () {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return dataarrop[number];
    }));
  },
  child: Row(
    children: <Widget>[
      Icon(Icons.flip_to_back),
      SizedBox(
        width: 10.0,
      ),
      Text(suggestions),
    ],
  ),
);
}
