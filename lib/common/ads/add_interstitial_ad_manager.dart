import 'dart:math';

import 'package:applovin_max/applovin_max.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../../build_constants.dart';
import '../../presentation/controller/app_controller.dart';
import '../util/app_util.dart';

class AddInterstitialAdManager {
  var _interstitialRetryAttempt = 0;

  initializeInterstitialAds({
    Function()? onAdLoadedCallback,
    Function()? onAdLoadFailedCallback,
    Function()? onAdDisplayedCallback,
    Function()? onAdDisplayFailedCallback,
    Function()? onAdClickedCallback,
    Function()? onAdHiddenCallback,
  }) {
    AppLovinMAX.setInterstitialListener(InterstitialListener(
      onAdLoadedCallback: (ad) {
        if (onAdLoadedCallback != null) onAdLoadedCallback();
        log('Interstitial ad loaded from ${ad.networkName}');
        _interstitialRetryAttempt = 0;
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        if (onAdLoadFailedCallback != null) onAdLoadFailedCallback();
        _interstitialRetryAttempt = _interstitialRetryAttempt + 1;
        int retryDelay = pow(2, min(6, _interstitialRetryAttempt)).toInt();
        log('Interstitial ad failed to load with code ${error.code} - retrying in ${retryDelay}s');

        Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
          AppLovinMAX.loadInterstitial(BuildConstants.idInterstitialAd);
        });
        if (Get.isRegistered<AppController>()) {
          Get.find<AppController>().avoidShowOpenApp = false;
        }
      },
      onAdDisplayedCallback: (ad) {
        if (onAdDisplayedCallback != null) onAdDisplayedCallback();
        if (Get.isRegistered<AppController>()) {
          Get.find<AppController>().avoidShowOpenApp = true;
        }
      },
      onAdDisplayFailedCallback: (ad, error) {
        if (onAdDisplayFailedCallback != null) onAdDisplayFailedCallback();
        if (Get.isRegistered<AppController>()) {
          Get.find<AppController>().avoidShowOpenApp = false;
        }
      },
      onAdClickedCallback: (ad) {
        if (onAdClickedCallback != null) onAdClickedCallback();
      },
      onAdHiddenCallback: (ad) {
        if (onAdHiddenCallback != null) onAdHiddenCallback();
        if (Get.isRegistered<AppController>()) {
          Get.find<AppController>().avoidShowOpenApp = false;
        }
      },
    ));
    // Load the first interstitial
    AppLovinMAX.loadInterstitial(BuildConstants.idInterstitialAd);
  }
}

showInterstitialAds(Function() onAdHiddenCallback) async {
  ConnectivityResult connectivityResult =
      await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    showToast('No internet connection, please try again later');
    onAdHiddenCallback();
  }
  bool? isInterstitialReady =
      await AppLovinMAX.isInterstitialReady(BuildConstants.idInterstitialAd);
  if (isInterstitialReady == true) {
    AppLovinMAX.setInterstitialListener(InterstitialListener(
      onAdLoadedCallback: (ad) {},
      onAdLoadFailedCallback: (adUnit, error) {
        if (Get.isRegistered<AppController>()) {
          Get.find<AppController>().avoidShowOpenApp = false;
        }
        onAdHiddenCallback();
      },
      onAdDisplayedCallback: (ad) {
        if (Get.isRegistered<AppController>()) {
          Get.find<AppController>().avoidShowOpenApp = true;
        }
      },
      onAdDisplayFailedCallback: (ad, error) {
        if (Get.isRegistered<AppController>()) {
          Get.find<AppController>().avoidShowOpenApp = false;
        }
      },
      onAdClickedCallback: (ad) {},
      onAdHiddenCallback: (ad) {
        if (Get.isRegistered<AppController>()) {
          Get.find<AppController>().avoidShowOpenApp = false;
        }
        AppLovinMAX.loadInterstitial(BuildConstants.idInterstitialAd);
        onAdHiddenCallback();
      },
    ));
    AppLovinMAX.showInterstitial(BuildConstants.idInterstitialAd);
  } else {
    showToast(AppTranslation.getString(TranslationConstants.errorLoadAds));
    AppLovinMAX.loadInterstitial(BuildConstants.idInterstitialAd);
  }
  await Future.delayed(const Duration(seconds: 1));
}
