import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AdsManager extends GetxController {
  var isActivityPaused = false.obs;
  final appOpenAd = Rxn<AppOpenAd>();
  var isShowingOpenAppAd = false.obs;
  var isOpenAppLoaded = false.obs;
  final interstitialAd = Rxn<InterstitialAd>();
  var numInterstitialLoadAttempts = 0.obs;
  var maxFailedLoadAttempts = 5.obs;

  @override
  void onInit() {
    loadOpenAppAd();
    super.onInit();
  }

  void loadOpenAppAd() async {
    AppOpenAd.load(
      adUnitId: 'ca-app-pub-6611686410771379/7336487350',
      // adUnitId: AppIds.openAppTest,
      orientation: AppOpenAd.orientationPortrait,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint("OpenApp Ad Loaded");
          appOpenAd.value = ad;
          isOpenAppLoaded.value = true;
        },
        onAdFailedToLoad: (error) {
          // Handle the error.
        },
      ),
    );
  }

  bool get isAdAvailable {
    return appOpenAd.value != null;
  }

  void showAdIfAvailable() async {
    print("Show OpenApp Ad");

    if (appOpenAd.value == null) {
      print('Tried to show ad before available.');
      loadOpenAppAd();
      return;
    }
    if (isShowingOpenAppAd.value) {
      print('Tried to show ad while already showing an ad.');
      return;
    }
    // Set the fullScreenContentCallback and show the ad.
    appOpenAd.value!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        isShowingOpenAppAd.value = true;
        print('$ad onAdShowedFullScreenContent');
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        isShowingOpenAppAd.value = false;
        ad.dispose();
        appOpenAd.value = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        print('$ad onAdDismissedFullScreenContent');
        isShowingOpenAppAd.value = false;
        ad.dispose();
        appOpenAd.value = null;
        loadOpenAppAd();
      },
    );
    appOpenAd.value!.show();
  }

 
}
