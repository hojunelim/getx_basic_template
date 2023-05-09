import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../lang/lang_en.dart';
import '../lang/lang_fr.dart';
import '../lang/lang_ko.dart';
import '../lang/lang_ja.dart';
import '../lang/lang_zh.dart';

class AppTranslations extends Translations {
  static get languageCodes {
    return {
      'en_US': {'name': 'ENG', 'data': enUS},
      'fr_FR': {'name': 'FRA', 'data': frFR},
      'ko_KR': {'name': '한국', 'data': koKR},
      'ja_JP': {'name': '日本', 'data': jaJP},
      'zh_CN': {'name': '中文', 'data': zhCN},
    };
  }

  static Locale locale(String key) {
    List langcode = key.split('_');
    return Locale(langcode[0], langcode[1]);
  }

  static Locale get fallbackLocale => const Locale('en', 'Us');

  @override
  Map<String, Map<String, String>> get keys {
    Map<String, Map<String, String>> codes = {};
    languageCodes.forEach((key, value) {
      codes[key] = value['data'];
    });
    return codes;
  }
}
