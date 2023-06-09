import 'dart:io';

import 'package:bloodpressure/common/ads/add_interstitial_ad_manager.dart';
import 'package:bloodpressure/common/constants/app_constant.dart';
import 'package:bloodpressure/common/constants/app_route.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final analytics = FirebaseAnalytics.instance;
  final appController = Get.find<AppController>();

  onPressHeartBeat() {
    analytics.logEvent(name: AppLogEvent.homeHeartRate);
    debugPrint("Logged ${AppLogEvent.homeHeartRate} at ${DateTime.now()}");

    if(appController.isPremiumFull.value) {
      Get.toNamed(AppRoute.heartBeatScreen);
    } else {
      if(appController.userLocation.compareTo("Other") == 0) {
        if(appController.firstPressMeasureNow) {
          showInterstitialAds(() {
            Get.toNamed(AppRoute.heartBeatScreen);
            appController.firstPressMeasureNow = false;
          });
        } else {
          Get.toNamed(AppRoute.heartBeatScreen);
        }
      } else {
        Get.toNamed(AppRoute.heartBeatScreen);
      }
    }

    // if (Platform.isIOS && appController.freeAdCount < 4) {
    //   appController.increaseFreeAdCount();
    //   Get.toNamed(AppRoute.heartBeatScreen);
    // } else {
    //   showInterstitialAds(() => Get.toNamed(AppRoute.heartBeatScreen));
    // }
  }

  onPressBloodPressure() {
    analytics.logEvent(name: AppLogEvent.homeBloodPressure);

    if(appController.isPremiumFull.value) {
      Get.toNamed(AppRoute.bloodPressureScreen);
    } else {
      if(appController.userLocation.compareTo("Other") == 0) {
        if(appController.firstPressBloodPressure) {
          showInterstitialAds(() {
            Get.toNamed(AppRoute.bloodPressureScreen);
            appController.firstPressBloodPressure = false;
          });
        } else {
          Get.toNamed(AppRoute.bloodPressureScreen);
        }
      } else {
        Get.toNamed(AppRoute.bloodPressureScreen);
      }
    }

    // if (Platform.isIOS && appController.freeAdCount < 4) {
    //   Get.toNamed(AppRoute.bloodPressureScreen);
    //   appController.increaseFreeAdCount();
    // } else {
    //   showInterstitialAds(() => Get.toNamed(AppRoute.bloodPressureScreen));
    // }
  }

  onPressBloodSugar() {
    analytics.logEvent(name: AppLogEvent.homeBloodSugar);
    Get.toNamed(AppRoute.bloodSugar);

    // if (Platform.isIOS && appController.freeAdCount < 4) {
    //   Get.toNamed(AppRoute.bloodSugar);
    //   appController.increaseFreeAdCount();
    // } else {
    //   showInterstitialAds(() => Get.toNamed(AppRoute.bloodSugar));
    // }
  }

  onPressWeightAndBMI() {
    analytics.logEvent(name: AppLogEvent.homeWeightBMI);
    Get.toNamed(AppRoute.weightBMI);

    // if (Platform.isIOS && appController.freeAdCount < 4) {
    //   Get.toNamed(AppRoute.weightBMI);
    //   appController.increaseFreeAdCount();
    // } else {
    //   showInterstitialAds(() => Get.toNamed(AppRoute.weightBMI));
    // }
  }

  onPressFoodScanner() async {
    analytics.logEvent(name: AppLogEvent.homeFoodScanner);

    // if ((Platform.isIOS && appController.freeAdCount < 4) || (Platform.isAndroid && appController.skipOneAd.value)) {
    //   Get.toNamed(AppRoute.foodScanner);
    //   appController.increaseFreeAdCount();
    // } else {
    //   showInterstitialAds(() => Get.toNamed(AppRoute.foodScanner));
    // }

    if(appController.isPremiumFull.value) {
      Get.toNamed(AppRoute.foodScanner);
    } else {
      if(appController.userLocation.compareTo("Other") != 0) {
        final prefs = await SharedPreferences.getInstance();
        int cntPressFoodScanner = prefs.getInt("cnt_press_food_scanner") ?? 0;

        if(cntPressFoodScanner < 2) {
          Get.toNamed(AppRoute.foodScanner);
          prefs.setInt("cnt_press_food_scanner", cntPressFoodScanner + 1);
        } else {
          Get.toNamed(AppRoute.iosSub);
        }
      } else {
        Get.toNamed(AppRoute.foodScanner);
      }
    }
    appController.skipOneAd.value = !appController.skipOneAd.value;
  }
}
