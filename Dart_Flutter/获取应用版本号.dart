import 'package:package_info/package_info.dart';
PackageInfo packageInfo = await PackageInfo.fromPlatform();
packageInfo.appName; // app名
packageInfo.packageName; // 包名
packageInfo.version; // 版本号
packageInfo.buildNumber; // 构建号