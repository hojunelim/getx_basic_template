import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobBanner extends StatelessWidget {
  AdMobBanner({this.size, required this.adUnitId, super.key});

  final String? size;
  /*
  320x50	배너	휴대전화 및 태블릿	BANNER
  320x100	대형 배너	휴대전화 및 태블릿	LARGE_BANNER
  300x250	IAB 중간 직사각형	휴대전화 및 태블릿	MEDIUM_RECTANGLE
  468 x 60	IAB 원본 크기 배너	태블릿	FULL_BANNER
  728x90	IAB 리더보드	태블릿	LEADERBOARD
  제공된 너비x적응형 높이	적응형 배너	휴대전화 및 태블릿	N/A
   */

  final String adUnitId;

  final Rx<BannerAd?> bannerAd = null.obs;
  final status = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Obx(() => Text("Status: ${status.value}")),
      (GetPlatform.isAndroid || GetPlatform.isIOS)
          ? getBanner()
          : const Text('ad'),
      const Text('admob bottom'),
    ]);
  }

  getBanner() {
    AdSize adSize = bannerSize();
    bannerAdInit(adSize);
    return Obx(() => bannerAd.value != null
        ? AdWidget(
            ad: bannerAd.value!,
          )
        : const Center(
            child: CircularProgressIndicator(),
          ));
  }

  bannerSize() {
    print('size: $size');
    switch (size) {
      case 'BANNER': //(320x50)
        return AdSize.banner;
      case 'LARGE_BANNER': //(320x100)
        return AdSize.largeBanner;
      case 'MEDIUM_RECTANGLE': //(300x250)
        return AdSize.mediumRectangle;
      case 'FULL_BANNER': //(468 x 60)
        return AdSize.fullBanner;
      case 'LEADERBOARD': //(728x90)
        return AdSize.leaderboard;
      case 'FLUID': //(제공된 너비x적응형 높이)
        return AdSize.fluid;
      default:
        return AdSize.banner;
    }
  }

  bannerAdInit(bannerSize) async {
    status.value = 'init';
    BannerAd(
            size: bannerSize,
            adUnitId: adUnitId,
            listener: BannerAdListener(
              onAdLoaded: (ad) {
                print('ad loaded');
                status.value = 'loaded';
                bannerAd.value = ad as BannerAd;
              },
              onAdFailedToLoad: (ad, error) {
                status.value = 'failed';
                print('ad loading failed');
                print(error);
                ad.dispose();
                bannerAd.value = null;
              },
            ),
            request: const AdRequest())
        .load();
  }
}
