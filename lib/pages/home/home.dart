import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/commons/globals.dart';
import '/commons/utils.dart';
import '/services/ad_service.dart';
import '/widgets/bounce_card.dart';
import '/widgets/page_wrap.dart';
import 'home_controller.dart';

class Home extends StatelessWidget {
  final Globals G = Get.find<Globals>();
  final AdService adService = Get.find<AdService>();
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController _ = Get.put(HomeController());

    return PageWrap(
        appbarLess: false,
        isSlivers: true,
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
              child: Container(
                  height: 80,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Obx(() {
                    return (adService.bannerAds['home_banner'] != null)
                        ? adService.showBanner('home_banner')
                        : const Text('ad');
                  })),
            ),
            BounceCard(
              child: const Text("interstitial"),
              onPressed: () async {
                adService.showInterstitial(G.adMobs['interstitial']!, () async {
                  print(' interstitial onUserEarnedReward');
                });
              },
            ),
            BounceCard(
              child: const Text("Rewarded"),
              onPressed: () async {
                adService.showRewarded(G.adMobs['rewarded']!, () async {
                  print(' rewarded onUserEarnedReward');
                });
              },
            ),
            BounceCard(
              child: const Text("rewarded_interstitial"),
              onPressed: () async {
                adService.showRewardedInterstitial(
                    G.adMobs['rewarded_interstitial']!, () async {
                  print(' rewarded_interstitial onUserEarnedReward');
                });
              },
            ),
            Container(
              height: 3000,
            )
          ],
        ));
  }
}
