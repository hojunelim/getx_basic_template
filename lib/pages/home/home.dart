import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../commons/globals.dart';
import '../../commons/utils.dart';
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
            Switch(
                value: G.theme == 0,
                onChanged: (bool value) {
                  G.setAttr('theme', value ? 0 : 1);
                }),
            Text("${G.concept} "),
          ],
        ),
        toolbar: [
          IconButton(
            icon: const Icon(Icons.change_circle),
            onPressed: () {
              G.setAttr('concept', Utils.randomMapKey(G.conceptList));
            },
          ),
        ],
        child: Card(
          color: context.theme.colorScheme.primary,
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: AdMobBanner(
                    adUnitId: G.adMobKeys['BannerAd'].toString(),
                    size: 'BANNER',
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
