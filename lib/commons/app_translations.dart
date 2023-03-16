import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../lang/lang_en.dart';
import '../lang/lang_fr.dart';
import '../lang/lang_ko.dart';
import '../lang/lang_ja.dart';
import '../lang/lang_zh.dart';

class AppTranslations extends Translations {
  static get languageCodes {
    return [
      ['en_US', 'ENG', enUS],
      ['fr_FR', 'FRA', frFR],
      ['ko_KR', '한국', koKR],
      ['ja_JP', '日本', jaJP],
      ['zh_CN', '中文', zhCN],
    ];
  }

  static Locale locale(index) {
    List langcode = languageCodes[index][0].split('_');
    return Locale(langcode[0], langcode[1]);
  }

  static Locale get fallbackLocale => const Locale('en', 'Us');

  static List<String> get languages {
    List<String> langs = [];
    languageCodes.forEach((element) {
      langs.add(element[1]);
    });
    return langs;
  }

  @override
  Map<String, Map<String, String>> get keys {
    Map<String, Map<String, String>> codes = {};
    languageCodes.forEach((element) {
      codes[element[0]] = element[2];
    });
    return codes;
  }
}
