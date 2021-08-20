参考：https://www.jianshu.com/p/5d44d26d3556

TextField(
  keyboardType: TextInputType.text,
  //过滤输入内容
  inputFormatters: [
    FilteringTextInputFormatter.allow(RegExp("[0-9]"))
  ],
  decoration: InputDecoration(
    contentPadding: EdgeInsets.all(10.0),
    hintText: 'Search',
    // border: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(20),
    //   borderSide: BorderSide(color: Colors.grey),
    // ),
    border: InputBorder.none,
  ),
  onChanged: _textFieldChanged,
  onSubmitted: _textFieldSubmitted,
  autofocus: false,
),


void _textFieldChanged(String str) {
  print(str);
}

void _textFieldSubmitted(String str) {
  print(str);
}
