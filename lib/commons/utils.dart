import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

class $u {
  static Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }

  static random(dynamic list) {
    if (list is List) {
      return randomListKey(list);
    } else if (list is Map) {
      return randomMapKey(list);
    } else if (list is String) {
      return randomStringKey(list);
    } else if (list is int) {
      return randomIntKey(list);
    } else {
      return null;
    }
  }

  static randomMapKey(Map map) {
    var keys = map.keys.toList();
    return keys[Random().nextInt(keys.length)];
  }

  static randomListKey(List list) {
    return list[Random().nextInt(list.length)];
  }

  static randomStringKey(String str) {
    return str[Random().nextInt(str.length)];
  }

  static randomIntKey(int num) {
    return Random().nextInt(num);
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

  static Color getColorScheme(BuildContext context, String color) {
    switch (color) {
      case 'primary':
        return context.theme.colorScheme.primary;
      case 'secondary':
        return context.theme.colorScheme.secondary;
      case 'tertiary':
        return context.theme.colorScheme.tertiary;
      case 'error':
        return context.theme.colorScheme.error;
      case 'background':
        return context.theme.colorScheme.background;
      case 'inversePrimary':
        return context.theme.colorScheme.inversePrimary;
      case 'surfaceTint':
        return context.theme.colorScheme.surfaceTint;
      default:
        return context.theme.colorScheme.primary;
    }
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

  static LottieBuilder lottie(String filePath,
      {double? width, double? height}) {
    if (filePath.contains('assets/images')) {
      return Lottie.asset(filePath, fit: BoxFit.contain);
    } else if (filePath.contains('http')) {
      return Lottie.network(filePath);
    } else {
      return Lottie.file(File(filePath), width: width, height: height);
    }
  }

  static snackbar(String message, {String position = 'bottom'}) {
    SnackPosition positionType = SnackPosition.BOTTOM;
    if (position == 'top') {
      positionType = SnackPosition.TOP;
    }
    Get.rawSnackbar(
        messageText: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black.withOpacity(0.5),
        snackPosition: positionType,
        margin: const EdgeInsets.all(20),
        borderRadius: 10,
        forwardAnimationCurve: Curves.easeOutBack,
        reverseAnimationCurve: Curves.easeInBack,
        duration: const Duration(seconds: 3),
        padding: const EdgeInsets.all(20));
  }
}
