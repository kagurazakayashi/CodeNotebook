import 'package:flutter/material.dart';

import 'text_widget.dart';

class TestPage extends StatefulWidget {
  const TestPage({
    super.key,
  });

  @override
  State<TestPage> createState() => TestPageState();
}

class TestPageState extends State<TestPage> {
  GlobalKey<TextWidgetState> appbarKey = GlobalKey();
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextWidget(
              key: appbarKey,
              text: i.toString(),
            ),
            Text(
              i.toString(),
              style: const TextStyle(
                fontSize: 50,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          appbarKey.currentState?.onsetState((++i).toString());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
