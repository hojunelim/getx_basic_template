import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class NativeSplash {
  static void splashInit() {
    WidgetsBinding widgetsBinding =
        WidgetsFlutterBinding.ensureInitialized(); //생명주기 리턴 받기
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  }

  static void splashRemove() async {
    print('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
  }
}
