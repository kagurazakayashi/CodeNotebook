import 'dart:io';

import 'package:flutter/services.dart';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

  Future<void> openAsset() async {
    String imagePath = await getAssetPath('assets/qrCode.png');
    print(">>> imagePath: $imagePath");
  }

  Future<String> getAssetPath(String asset) async {
    final path = await getLocalPath(asset);
    await Directory(p.dirname(path)).create(recursive: true);
    final file = File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(asset);
      await file.writeAsBytes(
        byteData.buffer.asUint8List(
          byteData.offsetInBytes,
          byteData.lengthInBytes,
        ),
      );
    }
    return file.path;
  }

  Future<String> getLocalPath(String path) async {
    return '${(await getApplicationSupportDirectory()).path}/$path';
  }
