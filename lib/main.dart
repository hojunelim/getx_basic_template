import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'commons/globals.dart';
import 'commons/stg_ctrl.dart';

import 'services/ad_service.dart';
import 'services/app_pages.dart';
import 'services/app_themes.dart';
import 'services/app_translations.dart';

import 'pages/home/home.dart';

void main() async {
  await initService();
  final appTheme = Get.put(AppThemes());

  Globals G = Get.find<Globals>();
  runApp(Obx(() => GetMaterialApp(
        title: G.appTitle,
        debugShowCheckedModeBanner: false,
        getPages: AppPages.routes,
        home: Home(),
        theme: appTheme.lightTheme(G.concept),
        darkTheme: appTheme.darkTheme(G.concept),
        themeMode: G.theme == 1 ? ThemeMode.light : ThemeMode.dark,
        locale: AppTranslations.locale(G.language),
        translations: AppTranslations(),
        fallbackLocale: AppTranslations.fallbackLocale,
      )));
}

Future initService() async {
  WidgetsFlutterBinding.ensureInitialized();
  //runApp 메소드의 시작 지점에서 Flutter 엔진과 위젯의 바인딩이 미리 완료되어 있게만들어줍니다.
  //이렇게 하지 않으면 runApp 메소드가 호출되기 전에 위젯이 렌더링되는 경우가 있습니다.
  //이렇게 하면 위젯이 렌더링되기 전에 Flutter 엔진이 초기화되어 있습니다.

  await Get.putAsync<StgCtrl>(() => StgCtrl().init());
  await Get.putAsync<Globals>(() => Globals().init());

  if (GetPlatform.isAndroid || GetPlatform.isIOS) {
    //애드몹 초기화
    Get.put(AdService());
  }

  if (GetPlatform.isAndroid) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: []); //상태바를 숨깁니다.
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    // 상태바 색상을 투명으로 만들어줍니다.
    // 이렇게 하지 않으면 안드로이드에서 상태바가 검은색으로 나타납니다.
  }
}
