import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'globals.dart';

class AdService extends GetxController {
  final G = Get.find<Globals>();
  BannerAd? bannerAd;
  InterstitialAd? interstitialAd;

  final RxBool _isLoadBanner = false.obs;
  final RxBool _isLoadInterstitial = false.obs;

  get isLoadBanner => _isLoadBanner.value;
  get isLoadInterstitial => _isLoadInterstitial.value;

  @override
  void onInit() async {
    MobileAds.instance.initialize();
    bannerAdInit();
    interstitialAdvert();
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

  interstitialAdvert() async {
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

  void showInterstitial() {
    if (_isLoadInterstitial.value) {
      interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) {
          print('$ad onAdShowedFullScreenContent.');
        },
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          print('$ad onAdDismissedFullScreenContent.');
          ad.dispose();
          interstitialAdvert();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          print('$ad onAdFailedToShowFullScreenContent: $error');
          ad.dispose();
          interstitialAdvert();
        },
        onAdImpression: (InterstitialAd ad) {
          print('$ad impression occurred.');
        },
      );
      interstitialAd!.show();
      interstitialAd!.dispose();
    }
  }
}
