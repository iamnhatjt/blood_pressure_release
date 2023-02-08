import 'dart:math';

import 'package:applovin_max/applovin_max.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../../build_constants.dart';
import '../../presentation/controller/app_controller.dart';
import '../util/app_util.dart';
import '../util/translation/app_translation.dart';

class AddRewardAdManager {
  var _rewardedAdRetryAttempt = 0;

  void initializeRewardedAds({
    Function()? onAdLoadedCallback,
    Function()? onAdLoadFailedCallback,
    Function()? onAdDisplayedCallback,
    Function()? onAdDisplayFailedCallback,
    Function()? onAdClickedCallback,
    Function()? onAdHiddenCallback,
    Function()? onAdReceivedRewardCallback,
  }) {
    AppLovinMAX.setRewardedAdListener(RewardedAdListener(
      onAdLoadedCallback: (ad) {
        if (onAdLoadedCallback != null) onAdLoadedCallback();
        log('---AD REWARD---onAdLoadedCallback');
        log('Rewarded ad loaded from ${ad.networkName}');
        _rewardedAdRetryAttempt = 0;
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        if (onAdLoadFailedCallback != null) onAdLoadFailedCallback();
        log('---AD REWARD---onAdLoadFailedCallback: $error');
        _rewardedAdRetryAttempt = _rewardedAdRetryAttempt + 1;

        int retryDelay = pow(2, min(6, _rewardedAdRetryAttempt)).toInt();
        log('Rewarded ad failed to load with code ${error.code} - retrying in ${retryDelay}s');

        Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
          AppLovinMAX.loadRewardedAd(BuildConstants.idRewardAppAd);
        });
        if (Get.isRegistered<AppController>()) {
          Get.find<AppController>().avoidShowOpenApp = false;
        }
      },
      onAdDisplayedCallback: (ad) {
        if (onAdDisplayedCallback != null) onAdDisplayedCallback();
        log('---AD REWARD---onAdDisplayedCallback');
        if (Get.isRegistered<AppController>()) {
          Get.find<AppController>().avoidShowOpenApp = true;
        }
      },
      onAdDisplayFailedCallback: (ad, error) {
        if (onAdDisplayFailedCallback != null) onAdDisplayFailedCallback();
        log('---AD REWARD---onAdDisplayFailedCallback: $error');
        if (Get.isRegistered<AppController>()) {
          Get.find<AppController>().avoidShowOpenApp = false;
        }
      },
      onAdClickedCallback: (ad) {
        if (onAdClickedCallback != null) onAdClickedCallback();
        log('---AD REWARD---onAdClickedCallback');
      },
      onAdHiddenCallback: (ad) {
        if (onAdHiddenCallback != null) onAdHiddenCallback();
        log('---AD REWARD---onAdHiddenCallback');
        if (Get.isRegistered<AppController>()) {
          Get.find<AppController>().avoidShowOpenApp = false;
        }
      },
      onAdReceivedRewardCallback: (ad, reward) {
        if (onAdReceivedRewardCallback != null) onAdReceivedRewardCallback();
        log('---AD REWARD---onAdReceivedRewardCallback');
        if (Get.isRegistered<AppController>()) {
          Get.find<AppController>().avoidShowOpenApp = false;
        }
      },
    ));
    AppLovinMAX.loadRewardedAd(BuildConstants.idRewardAppAd);
  }
}

showRewardAds(Function() onAdHiddenCallback) async {
  ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    showToast('No internet connection, please try again later');
    onAdHiddenCallback();
  }
  bool? isRewardReady = await AppLovinMAX.isRewardedAdReady(BuildConstants.idRewardAppAd);
  if (isRewardReady == true) {
    AppLovinMAX.setRewardedAdListener(RewardedAdListener(
      onAdLoadedCallback: (ad) {},
      onAdLoadFailedCallback: (adUnit, error) {
        onAdHiddenCallback();
        if (Get.isRegistered<AppController>()) {
          Get.find<AppController>().avoidShowOpenApp = false;
        }
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
      },
      onAdReceivedRewardCallback: (ad, reward) async {
        onAdHiddenCallback();
        await Future.delayed(const Duration(seconds: 2));
        AppLovinMAX.loadRewardedAd(BuildConstants.idRewardAppAd);
        if (Get.isRegistered<AppController>()) {
          Get.find<AppController>().avoidShowOpenApp = false;
        }
      },
    ));
    AppLovinMAX.showRewardedAd(BuildConstants.idRewardAppAd);
  } else {
    showToast(AppTranslation.getString(TranslationConstants.errorLoadAds));
    AppLovinMAX.loadRewardedAd(BuildConstants.idRewardAppAd);
  }
  await Future.delayed(const Duration(seconds: 1));
}
