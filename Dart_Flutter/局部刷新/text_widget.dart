import 'package:flutter/material.dart';

class TextWidget extends StatefulWidget {
  const TextWidget({
    super.key,
    this.text,
  });
  final String? text;

  @override
  State<TextWidget> createState() => TextWidgetState();
}

class TextWidgetState extends State<TextWidget> {
  String _text = "";

  @override
  void initState() {
    _text = widget.text ?? "";
    super.initState();
  }

  void onsetState(String str) {
    setState(() {
      _text = str;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: const TextStyle(
        fontSize: 50,
      ),
    );
  }
}
