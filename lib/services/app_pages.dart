import 'package:get/get.dart';
import '/pages/home/index.dart' as home;

abstract class AppPages {
  static final routes = [
    GetPage(
      name: '/home',
      page: () => home.Index(),
      binding: home.Binding(),
    ),
  ];
}
