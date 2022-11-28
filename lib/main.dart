import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/globals/utils/hive_core.dart';
import 'app/globals/utils/native_splash.dart';
import 'app/modules/home/home_page.dart';
import 'app/routes/app_pages.dart';

void main() async {
  NativeSplash.splashInit();
  await HiveCore.init();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    defaultTransition: Transition.fade,
    getPages: AppPages.routes,
    home: HomePage(),
  ));
}
