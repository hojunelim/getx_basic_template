import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService extends GetxController {
  final bannerAds = <String, BannerAd>{}.obs;

  @override
  void onInit() async {
    MobileAds.instance.initialize();
    super.onInit();
  }

  bannerSize(String size) {
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

  // admob 배너 광고 함수
  loadBanner(String key, Map<String, String>? admob) async {
    if (admob == null) return;
    if (bannerAds[key] == null) {
      bannerAds[key] = BannerAd(
        size: bannerSize(admob['size'].toString()), //AdSize.banner,
        adUnitId: admob['key'].toString(),
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            print('$BannerAd loaded.');
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            print('$BannerAd failedToLoad: $error');
            bannerAds.remove(key);
          },
          onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
          onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
          onAdImpression: (Ad ad) => print('$BannerAd impression occurred.'),
        ),
      );
      await bannerAds[key]!.load();
    }
  }

  Widget showBanner(String bannerName) {
    return AdWidget(ad: bannerAds[bannerName]!);
  }

  //전면광고 보여주기
  void showInterstitial(Map<String, String>? admob, Function callback) async {
    if (admob == null) return;
    await InterstitialAd.load(
        adUnitId: admob['key'].toString(),
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            ad.show();
            callback();
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
  }

  // admob 보상형 전면 광고 함수
  void showRewarded(Map<String, String>? admob, Function callback) async {
    if (admob == null) return;
    await RewardedAd.load(
      adUnitId: admob['key'].toString(),
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (RewardedAd ad) {
              print(" 광고1 admob onAdDismissedFullScreenContent 광고1");
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
              print(" 광고2 admob onAdFailedToShowFullScreenContent error:");
              print(error);
              ad.dispose();
            },
          );
          ad.show(onUserEarnedReward: (ad, reward) {
            print(" 광고3 admob onAdFailedToShowFullScreenContent error:");
            callback();
          });
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('admob onAdFailedToLoad : $error');
          callback();
        },
      ),
    );
  }

  void showRewardedInterstitial(
      Map<String, String>? admob, Function callback) async {
    if (admob == null) return;
    await RewardedInterstitialAd.load(
      adUnitId: admob['key'].toString(),
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (RewardedInterstitialAd ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) {
              print('$ad onAdDismissedFullScreenContent.');
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent:
                (RewardedInterstitialAd ad, AdError error) {
              print('$ad onAdFailedToShowFullScreenContent: $error');
              ad.dispose();
            },
            onAdShowedFullScreenContent: (RewardedInterstitialAd ad) =>
                print('$ad onAdShowedFullScreenContent.'),
          );
          ad.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
            print(
                '$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
            callback();
          });
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedInterstitialAd failed to load: $error');
          callback();
        },
      ),
    );
  }
}
