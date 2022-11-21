import 'dart:math';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class Utils {
  static Future<List<Map>> readJsonFile(String filePath) async {
    var input = await File(filePath).readAsString();
    return jsonDecode(input);
  }

  static randomColor() {
    final colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
      Colors.pink,
      Colors.teal,
      Colors.cyan,
      Colors.lime,
      Colors.indigo,
      Colors.brown,
      Colors.grey,
      Colors.amber,
      Colors.deepOrange,
      Colors.deepPurple,
      Colors.lightBlue,
      Colors.lightGreen,
      Colors.limeAccent,
      Colors.blueGrey,
      Colors.black,
      Colors.white,
    ];
    return colors[Random().nextInt(colors.length)];
  }
}
