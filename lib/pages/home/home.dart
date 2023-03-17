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
        child: Column(
          children: [
            Card(
              child: AdMobBanner(
                adUnitId: G.adMobKeys['BannerAd'].toString(),
                size: 'BANNER',
              ),
            ),
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
                  Text('Hello'.trArgs()),
                ],
              ),
            ),
          ],
        ));
  }
}
