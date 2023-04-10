import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../commons/globals.dart';
import '../../commons/utils.dart';
import '../../widgets/admob_widget.dart';
import '../../widgets/bounce_card.dart';
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
            Text("${G.concept} "),
          ],
        ),
        toolbar: [
          IconButton(
            icon: Icon(G.theme == 0 ? Icons.nightlight_round : Icons.sunny),
            onPressed: () {
              G.setAttr('theme', G.theme == 0 ? 1 : 0);
            },
          ),
          IconButton(
            icon: const Icon(Icons.change_circle),
            onPressed: () {
              G.setAttr('concept', $u.randomMapKey(G.conceptList));
            },
          ),
        ],
        child: Column(
          children: [
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Language: "),
                  DropdownButton<String>(
                    value: G.language,
                    onChanged: (String? value) {
                      G.setAttr('language', value);
                    },
                    items: G.languageList.keys
                        .map<DropdownMenuItem<String>>((String key) {
                      return DropdownMenuItem<String>(
                        value: key,
                        child: Text(G.languageList[key]['name']),
                      );
                    }).toList(),
                  ),
                  Text('Hello'.tr),
                ],
              ),
            ),
            Card(
              child: SizedBox(
                height: 80,
                child: AdMobBanner(
                  adUnitId: G.adMobKeys['BannerAd'].toString(),
                  size: 'BANNER',
                ),
              ),
            ),
            SizedBox.square(
              dimension: 100,
              child: BounceCard(
                child: const Text("BounceCard"),
                onPressed: () {
                  Get.rawSnackbar(
                    message: 'BounceCard',
                  );
                },
              ),
            ),
          ],
        ));
  }
}
