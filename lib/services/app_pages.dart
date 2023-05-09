import 'package:get/get.dart';

import '../pages/home/home.dart';

abstract class AppPages {
  static final routes = [
    GetPage(
      name: '/home',
      page: () => Home(),
    ),
  ];
}
