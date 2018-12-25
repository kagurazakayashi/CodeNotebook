  final aa = ['a', 'b', 'c', 'aa', 'bb', 'cc', 'aaa', 'bbb', 'ccc'];
  var bb = 0;
  Widget _buildCupertinoPicker() {
    return CupertinoPicker.builder(
      // backgroundColor: Colors.grey[50],
      diameterRatio: 1.2,
      // offAxisFraction: 0,
      // useMagnifier: true,
      // magnification: 1.2,
      scrollController: FixedExtentScrollController(initialItem: bb),
      childCount: aa.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildCPRow(aa, bb);
      },
      itemExtent: 200,
      onSelectedItemChanged: (int value) {
        setState(() {
          bb = value;
        });

        print(value);
      },
    );
  }

  Widget _buildCPRow(List rowdata, int index) {
    return CupertinoPicker(
      backgroundColor: Colors.blueGrey[50],
      diameterRatio: 1.2,
      // offAxisFraction: 0,
      // useMagnifier: true,
      // magnification: 1.2,
      scrollController: FixedExtentScrollController(initialItem: 1),
      children: <Widget>[
        // _buildSuggestions(rowdata),
        // new Text(index == 0 ? " " : rowdata[index - 1],
        //     style: new TextStyle(fontSize: 30.0),
        //     textAlign: TextAlign.center),
        new Text(rowdata[index],
            style: new TextStyle(fontSize: 30.0), textAlign: TextAlign.center),
        // new Text(index == rowdata.length - 1 ? " " : rowdata[index + 1],
        //     style: new TextStyle(fontSize: 30.0),
        //     textAlign: TextAlign.center),
      ],
      itemExtent: 50,
      onSelectedItemChanged: (int value) {
        // print("000" + value);
      },
    );
  }
