import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

class Utils {
  static randomMapKey(Map map) {
    var keys = map.keys.toList();
    return keys[Random().nextInt(keys.length)];
  }

  static randomListKey(List list) {
    return list[Random().nextInt(list.length)];
  }

  static Color colorBrightness(Color color, int brightness) {
    if (brightness > 0) {
      return lighten(color, brightness);
    } else {
      return darken(color, brightness.abs());
    }
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide >= 600;
  }

  /// Darken a color by [percent] amount (100 = black)
  static Color darken(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var f = 1 - percent / 100;
    return Color.fromARGB(c.alpha, (c.red * f).round(), (c.green * f).round(),
        (c.blue * f).round());
  }

  /// Lighten a color by [percent] amount (100 = white)
  static Color lighten(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var p = percent / 100;
    return Color.fromARGB(
        c.alpha,
        c.red + ((255 - c.red) * p).round(),
        c.green + ((255 - c.green) * p).round(),
        c.blue + ((255 - c.blue) * p).round());
  }

  static intToDateTime(int timestamp) {
    var d = DateTime.fromMillisecondsSinceEpoch(timestamp);
    String dateSlug =
        "${d.year.toString()}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
    return dateSlug;
  }

  static Future<String> appDir() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<String> extDir() async {
    Directory? directory = await getExternalStorageDirectory();
    return directory!.path;
  }

  static isFile(String? filePath) {
    if (filePath == null || filePath == '') return false;
    if (filePath.contains('assets')) return true;
    return File(filePath).existsSync();
  }

  static Future<bool> delFile(String filePath) async {
    if (filePath == '') return false;
    File imageExist = File(filePath);
    if (await imageExist.exists()) {
      imageExist.delete();
      return true;
    } else {
      return false;
    }
  }

  static Future<File?> saveFile(File file, String newPath) async {
    await delFile(newPath); //파일이 이미 있을경우

    try {
      return await file.copy(newPath);
    } catch (e) {
      print(e);
      print("filePath: ${file.path}");
      print("newPath: $newPath");
      return null;
    }
  }

  static ImageProvider<Object> imageWidget(String? filePath) {
    if (filePath == null || filePath == '' || isFile(filePath) == false) {
      return const AssetImage('assets/images/no-image.png');
    }

    if (filePath.contains('assets')) {
      return AssetImage(filePath);
    } else {
      return FileImage(File(filePath));
    }
  }
}
