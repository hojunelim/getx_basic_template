import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_basic_template/services/ad_service.dart';
import '../../commons/globals.dart';
import '../../commons/utils.dart';
import '../../widgets/bounce_card.dart';
import '../../widgets/page_wrap.dart';
import 'home_controller.dart';

class Home extends StatelessWidget {
  final Globals G = Get.find<Globals>();
  final AdService adService = Get.find<AdService>();
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
              child: Container(
                  height: 80,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Obx(() {
                    return (adService.bannerAds[G.adMobKeys['Banner']] != null)
                        ? adService.showBanner(G.adMobKeys['Banner'])
                        : const Text('ad');
                  })),
            ),
            SizedBox.square(
              dimension: 100,
              child: BounceCard(
                child: const Text("full screen ad"),
                onPressed: () async {
                  adService.showRewardedInterstitial(
                      G.adMobKeys['RewardedInterstitial'] ?? '', () async {
                    print(' rewardedInterstitial onUserEarnedReward');
                  });
                },
              ),
            ),
          ],
        ));
  }
}
