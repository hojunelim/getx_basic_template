import 'package:get/get.dart';
import '../modules/home/home_page.dart';

abstract class AppPages {
  static final routes = [
    GetPage(
      name: '/home',
      page: () => HomePage(),
    ),
  ];
}
