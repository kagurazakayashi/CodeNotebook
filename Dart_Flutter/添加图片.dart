/* 插入图片

pubspec.yaml:

flutter:
  assets:
    - assets/background.png
    - assets/my_icon.png
    - assets/2.0x/my_icon.png
    - assets/3.0x/my_icon.png
*/

Widget build(BuildContext context) {
  return new DecoratedBox(
    decoration: new BoxDecoration(
      image: new DecorationImage(
        image: new AssetImage('assets/background.png'),
      ),
    ),
  );
}

// https://www.codingsky.com/doc/flutter/assets-and-images.html
