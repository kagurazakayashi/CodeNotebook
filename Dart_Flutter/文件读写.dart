Future<File> fileio() async {
  final Directory extDir = await getApplicationDocumentsDirectory();
  final String dirPath = extDir.path;
  await Directory(dirPath).create(recursive: true);
  final String filePath = '$dirPath/conversion.txt';
  return new File(filePath);
}
writeCounter(File userfile, String filevalue) {
  return userfile.writeAsString(filevalue);
}
Future<String> readCounter(File userfile) async {
  try {
    String contents = await userfile.readAsString();
    return contents;
  } catch (e) {
    // If we encounter an error, return 0
    return "error";
  }
}
