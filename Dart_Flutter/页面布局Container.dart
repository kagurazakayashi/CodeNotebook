Container(
  width: 190,
  height: 38,
  padding: const EdgeInsets.only(left: 25.0, right: 25.0),
  // decoration: BoxDecoration(
  //     border:
  //         new Border.all(width: 1.0, color: Color(0xffefdab9)),
  //     borderRadius:
  //         BorderRadius.all(new Radius.circular(10.0))),
  // foregroundDecoration: BoxDecoration(
  //     border:
  //         new Border.all(width: 1.0, color: Color(0xffefdab9)),
  //     borderRadius:
  //         BorderRadius.all(new Radius.circular(10.0))),
  child: RaisedButton(
    color: Color(0xff574c4f),
    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
    child: Text('选择时间区间',
        style: TextStyle(color: Color(0xffefdab9))),
    onPressed: () {
      showPickerDateRange(context);
    },
  ),
),
