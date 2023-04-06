import 'dart:io';

/* Yashi Flutter Class Generator  README.md
# Flutter 类创建工具
根据雅诗个人代码习惯，一键创建 Flutter 类的工具。
## 在命令行中使用：
  - dart newclass.dart <类名> [小写类名]
  - 需要先 cd 到 lib 的上一级文件夹执行此命令。
  - 类名需要使用驼峰式命名法，首字母将自动转为大写。
  - 小写类名可选，如果不填写，则使用类名的 小写 + `_` 分隔形式。
  - 示例: `dart newclass.dart MyNewClass`
    - 生成的文件：
      - my_new_class/my_new_class_widget.dart
      - my_new_class/my_new_class_state.dart
      - my_new_class/my_new_class_func.dart
    - 文件中的类名为：
      - MyNewClassWidget
      - MyNewClassState
      - MyNewClassFunc
## 创建的代码包括：
  - 构造函数
  - 析构函数
  - Widget build 函数
  - createState 函数
  - initState 函数
  - setState 函数
  - func 类 $delegate 创建和 implements
  - func 类 $delegate 的 setState 函数
## 可配置项：
  - 以下配置项均为 `class NewClass` 中的 `static const String`
  - 换行符：修改常量 `wrap`
  - 外观库：修改常量 `material`
  - 后缀名：修改常量 `widgetL, stateL, funcL, stateU, funcU, delegate`
  - 基本目录: 修改常量 `lib`
## 协议：
Copyright (c) 2023 KagurazakaYashi. 
Yashi Flutter Class Generator is licensed under Mulan PSL v2.
You can use this software according to the terms and conditions of the Mulan PSL v2.
You may obtain a copy of Mulan PSL v2 at:
         http://license.coscl.org.cn/MulanPSL2 
THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
See the Mulan PSL v2 for more details.
*/

void main(List<String> arguments) {
  List<String> allPrint = ["Yashi Flutter Class Generator 1.2"];
  if (arguments.isEmpty || arguments.length > 2) {
    allPrint.add("Usage: dart newclass.dart <ClassName (UpperCamelCase identifier)> [lower_name]");
    allPrint.add("  e.g. `dart newclass.dart MyNewClass` -> `class MyNewClass*` + `my_new_class_*.dart`");
  } else {
    String className = arguments[0];
    String lowerName = "";
    if (arguments.length == 2) {
      lowerName = arguments[1];
    }
    NewClass newClass = NewClass(className, lowerName);
    allPrint.add("Input class name: $className");
    allPrint.add("Class name: ${newClass.name}");
    allPrint.add("Lower file name: ${newClass.lower}.dart");
    allPrint.add("");
    List<String> widget = newClass.fWidget();
    List<String> state = newClass.fState();
    List<String> func = newClass.fFunc();
    String l = "=" * 5;
    allPrint.add("$l ${widget[0]} $l");
    allPrint.add(widget[1]);
    allPrint.add("$l ${state[0]} $l");
    allPrint.add(state[1]);
    allPrint.add("$l ${func[0]} $l");
    allPrint.add(func[1]);
  }
  print(allPrint.join(NewClass.wrap));
}

class NewClass {
  static const String lib = "lib/";
  static const String wrap = "\n";
  static const String material = "material";
  static const String widgetL = "widget";
  static const String stateL = "state";
  static const String funcL = "func";
  static const String stateU = "State";
  static const String funcU = "Func";
  static const String delegate = "Delegate";

  static const String importPackage = "import 'package:";
  static const String import = "import './";
  static const String dart = ".dart";
  static const String override = "  @override";
  late String name;
  late String lower;

  NewClass(String name, String lower) {
    this.name = name.substring(0, 1).toUpperCase() + name.substring(1);
    if (lower.isEmpty) {
      List<String> lowerArr = [];
      for (int i = 0; i < this.name.length; i++) {
        String char = this.name[i];
        if (isUpperCase(char)) {
          if (i > 0) {
            lowerArr.add("_");
          }
          lowerArr.add(char.toLowerCase());
        } else {
          lowerArr.add(char);
        }
      }
      this.lower = lowerArr.join("");
    } else {
      this.lower = lower;
    }
    newDir();
  }

  void newDir() {
    Directory directory = Directory("$lib$lower");
    if (!directory.existsSync()) {
      directory.createSync();
    }
  }

  bool isUpperCase(String char) {
    return char.toUpperCase() == char;
  }

  List<String> fWidget() {
    String fileName = "${lower}_$widgetL$dart";
    List<String> code = [
      "${importPackage}flutter/$material$dart';",
      "$import${lower}_$stateL$dart';",
      "",
      "class $name extends StatefulWidget {",
      "  const $name({super.key});",
      "",
      override,
      "  State<$name> createState() => $name$stateU();",
      "}",
      "",
    ];
    fileName = "$lib$lower/$fileName";
    File file = File(fileName);
    file.writeAsStringSync(code.join(wrap));
    return [fileName, code.join(wrap)];
  }

  List<String> fState() {
    String fileName = "${lower}_$stateL$dart";
    List<String> code = [
      "${importPackage}flutter/$material$dart';",
      "$import${lower}_$widgetL$dart';",
      "$import${lower}_$funcL$dart';",
      "",
      "class $name$stateU extends State<$name> implements $name$funcU$delegate {",
      "",
      "  final $name$funcU f = $name$funcU();",
      "",
      override,
      "  Widget build(BuildContext context) {",
      "    return Scaffold(",
      "      appBar: AppBar(",
      "        title: const Text('$name'),",
      "      ),",
      "      body: Container(",
      "        child: const Text('$name'),",
      "      ),",
      "    );",
      "  }",
      "",
      override,
      "  void initState() {",
      "    super.initState();",
      "    print('init $name$stateU');",
      "    f.delegate = this;",
      "    setState(() {",
      "    });",
      "  }",
      "",
      override,
      "  void dispose() {",
      "    f.dispose();",
      "    print('dispose $name$stateU');",
      "    super.dispose();",
      "  }",
      "}",
      "",
    ];
    fileName = "$lib$lower/$fileName";
    File file = File(fileName);
    file.writeAsStringSync(code.join(wrap));
    return [fileName, code.join(wrap)];
  }

  List<String> fFunc() {
    String fileName = "${lower}_$funcL$dart";
    List<String> code = [
      "abstract class $name$funcU$delegate {",
      "  void setState(Function() fn);",
      "}",
      "",
      "class $name$funcU {",
      "  $name$funcU$delegate? delegate;",
      "",
      "  $name$funcU() {",
      "    print('init $name$funcU');",
      "    delegate?.setState(() {",
      "    });",
      "  }",
      "",
      "  void dispose() {",
      "    print('dispose $name$funcU');",
      "  }",
      "}",
      "",
    ];
    fileName = "$lib$lower/$fileName";
    File file = File(fileName);
    file.writeAsStringSync(code.join(wrap));
    return [fileName, code.join(wrap)];
  }
}
