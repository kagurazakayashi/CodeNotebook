import 'package:path_provider/path_provider.dart';

  Future<void> findDir({String dirpath = "/"}) async {
    Directory? dir;
    if (Global.i.isApple) {
      // 获取应用目录
      dir = await getApplicationDocumentsDirectory();
      print("[Application Downloads]: $dir");

      path = dir.path;
    } else {
      // 获取外部存储目录
      dir = await getExternalStorageDirectory();
      print("[External Storage Directories]: $dir");

      if (dir == null) {
        return;
      }
      path = dir.path;
    }
    if (dirpath != "/") {
      // 如果不是根目录，那么拼接目录
      dir = Directory(path + dirpath);
    }
    // 获取文件列表
    fileList = dir.listSync();
    // 根据地址排序
    fileList.sort(((a, b) {
      // 如果a是文件夹，b是文件，那么a排在前面
      if (a is Directory && b is File) {
        return -1;
      }
      // 如果a是文件，b是文件夹，那么b排在前面
      if (a is File && b is Directory) {
        return 1;
      }
      // 如果a和b都是文件夹，那么按照文件夹名称排序
      return p.basename(a.path).compareTo(p.basename(b.path));
    }));
    // 更新页面
    if (mounted) {
      setState(() {});
    }
  }