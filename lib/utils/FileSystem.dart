import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Storage {
  static Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/ocr.txt');
  }

  static Future writeText(String text) async {
    final file = await _localFile;
    file.writeAsString(text);
  }
}
