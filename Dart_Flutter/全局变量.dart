// 直接建立一个 Global 类，里面是全局变量
class Global {
  static String textContent = 'hello';
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");
}

/*
用的时候直接用：
Text(Global.textContent), // 读
GestureDetector(
  onTap: () {
    setState(() {
      Global.textContent = 'hi'; // 写
    });
  },
)
*/

// https://blog.csdn.net/qq6696009/article/details/112251925