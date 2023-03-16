import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'globals.dart';

class AdController extends GetxController {
  final G = Get.find<Globals>();
  BannerAd? bannerAd;
  InterstitialAd? interstitialAd;

  final RxBool _isLoadBanner = false.obs;
  final RxBool _isLoadInterstitial = false.obs;

  get isLoadBanner => _isLoadBanner.value;
  get isLoadInterstitial => _isLoadInterstitial.value;

  @override
  void onInit() {
    if (GetPlatform.isAndroid || GetPlatform.isIOS) {
      MobileAds.instance.initialize();
      bannerAdInit();
    }
    super.onInit();
  }

  bannerAdInit() {
    _isLoadBanner.value = false;
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: G.adMobKeys['BannerAd'] ?? '',
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            print('ad loaded');
            _isLoadBanner.value = true;
          },
          onAdFailedToLoad: (ad, error) {
            print('ad loading failed');

            print(error);
            _isLoadBanner.value = false;
          },
        ),
        request: const AdRequest())
      ..load();
  }

  nativeAdInit() {}

  interstitialAdvert() {
    _isLoadInterstitial.value = false;
    InterstitialAd.load(
        adUnitId: G.adMobKeys['interstitial'] ?? '',
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            interstitialAd = ad;
            print('interstitial ad loaded');
            _isLoadInterstitial.value = true;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
            _isLoadInterstitial.value = false;
          },
        ));
  }
}
