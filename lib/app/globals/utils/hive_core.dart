import 'package:hive_flutter/hive_flutter.dart';
// import '../../data/model/diary_model.dart';
// import '../../data/model/person_model.dart';

class HiveCore {
  static init() async {
    await Hive.initFlutter();
    registerAdapter();
    return Hive;
  }

  static registerAdapter() {
    //Hive.registerAdapter(DiaryModelAdapter());
    //Hive.registerAdapter(PersonModelAdapter());
  }
}
