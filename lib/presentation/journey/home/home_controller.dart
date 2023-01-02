import 'dart:io';

import 'package:bloodpressure/common/ads/add_interstitial_ad_manager.dart';
import 'package:bloodpressure/common/constants/app_constant.dart';
import 'package:bloodpressure/common/constants/app_route.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final analytics = FirebaseAnalytics.instance;
  final appController = Get.find<AppController>();

  onPressHeartBeat() {
    analytics.logEvent(name: AppLogEvent.homeHeartRate);
    debugPrint("Logged ${AppLogEvent.homeHeartRate} at ${DateTime.now()}");
    if (Platform.isIOS && appController.freeAdCount < 4) {
      appController.increaseFreeAdCount();
      Get.toNamed(AppRoute.heartBeatScreen);
    } else {
      showInterstitialAds(() => Get.toNamed(AppRoute.heartBeatScreen));
    }
  }

  onPressBloodPressure() {
    analytics.logEvent(name: AppLogEvent.homeBloodPressure);
    if (Platform.isIOS && appController.freeAdCount < 4) {
      Get.toNamed(AppRoute.bloodPressureScreen);
      appController.increaseFreeAdCount();
    } else {
      showInterstitialAds(() => Get.toNamed(AppRoute.bloodPressureScreen));
    }
  }

  onPressBloodSugar() {
    analytics.logEvent(name: AppLogEvent.homeBloodSugar);

    if (Platform.isIOS && appController.freeAdCount < 4) {
      Get.toNamed(AppRoute.bloodSugar);
      appController.increaseFreeAdCount();
    } else {
      showInterstitialAds(() => Get.toNamed(AppRoute.bloodSugar));
    }
  }

  onPressWeightAndBMI() {
    analytics.logEvent(name: AppLogEvent.homeWeightBMI);
    if (Platform.isIOS && appController.freeAdCount < 4) {
      Get.toNamed(AppRoute.weightBMI);
      appController.increaseFreeAdCount();
    } else {
      showInterstitialAds(() => Get.toNamed(AppRoute.weightBMI));
    }
  }

  onPressFoodScanner() {
    analytics.logEvent(name: AppLogEvent.homeFoodScanner);
    if ((Platform.isIOS && appController.freeAdCount < 4) || (Platform.isAndroid && appController.skipOneAd.value)) {
      Get.toNamed(AppRoute.foodScanner);
      appController.increaseFreeAdCount();
    } else {
      showInterstitialAds(() => Get.toNamed(AppRoute.foodScanner));
    }
    appController.skipOneAd.value = !appController.skipOneAd.value;
  }
}
