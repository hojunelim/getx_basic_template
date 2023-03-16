import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../commons/globals.dart';
import '../../widgets/admob_widget.dart';
import '../../widgets/page_wrap.dart';
import 'home_controller.dart';

class Home extends StatelessWidget {
  final Globals G = Get.find<Globals>();
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController _ = Get.put(HomeController());

    return PageWrap(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(G.appTitle),
          ],
        ),
        child: Card(
          color: context.theme.colorScheme.primary,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: AdMobBanner(
              adUnitId: G.adMobKeys['BannerAd'].toString(),
              size: 'MEDIUM_RECTANGLE',
            ),
          ),
        ));
  }
}
