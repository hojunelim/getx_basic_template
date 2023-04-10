import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

class $ {
  static late SharedPreferences prefs;

  Future<$> init() async {
    print("shardValue onInit");
    prefs = await SharedPreferences.getInstance();
    return this;
  }

  static get(String key, {String? type}) {
    if (type == 'int') {
      return prefs.getInt(key) ?? 0;
    } else if (type == 'double') {
      return prefs.getDouble(key) ?? 0.0;
    } else if (type == 'bool') {
      return prefs.getBool(key) ?? false;
    } else if (type == 'list') {
      return prefs.getStringList(key) ?? [];
    }
  }

  static set(String key, dynamic value) {
    if (value is int) {
      return prefs.setInt(key, value);
    } else if (value is double) {
      return prefs.setDouble(key, value);
    } else if (value is bool) {
      return prefs.setBool(key, value);
    } else if (value is List<String>) {
      return prefs.setStringList(key, value);
    }
    prefs.reload();
  }

  static remove(String key) {
    return prefs.remove(key);
  }

  static clear() {
    return prefs.clear();
  }

  static containsKey(String key) {
    return prefs.containsKey(key);
  }
}
