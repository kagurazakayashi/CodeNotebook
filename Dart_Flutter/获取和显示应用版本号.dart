// 应用版本号 软件版本号
// https://pub.dev/packages/package_info_plus

import 'package:package_info_plus/package_info_plus.dart';

// ...

// Be sure to add this line if `PackageInfo.fromPlatform()` is called before runApp()
WidgetsFlutterBinding.ensureInitialized();

// ...

PackageInfo packageInfo = await PackageInfo.fromPlatform();

String appName = packageInfo.appName;
String packageName = packageInfo.packageName;
String version = packageInfo.version;
String buildNumber = packageInfo.buildNumber;


// 底部右下角显示版本号 底部版本号

class _MyHomePageState extends State<MyHomePage> {
  String _version = "";

  Future<void> loadVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = "Version: ${packageInfo.version} (${packageInfo.buildNumber})";
    });
    // packageInfo.packageName, packageInfo.appName,
  }

  @override
  void initState() {
    super.initState();
    loadVersion();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Material(
      child: Stack(
        children: [
          Container(
            width: screenSize.width - 10,
            height: 20,
            margin: EdgeInsets.only(top: screenSize.height - 20, left: 5),
            child: Row(
              children: <Widget>[
                const Text(
                  "2023 © Yashi",
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.left,
                ),
                const Expanded(child: SizedBox()),
                Text(
                  _version,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
