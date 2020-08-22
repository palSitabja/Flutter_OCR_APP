import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Storage {
  static Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();
    return directory.path;
  }

  static Future<File> setFileName(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName.txt');
  }

  static Future writeText(String text,String fileName) async {
    final file = await setFileName(fileName);
    file.writeAsString(text);
  }
}
