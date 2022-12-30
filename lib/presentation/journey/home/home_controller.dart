import 'package:bloodpressure/common/ads/add_interstitial_ad_manager.dart';
import 'package:bloodpressure/common/constants/app_constant.dart';
import 'package:bloodpressure/common/constants/app_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final analytics = FirebaseAnalytics.instance;

  onPressHeartBeat() {
    analytics.logEvent(name: AppLogEvent.homeHeartRate);
    debugPrint("Logged ${AppLogEvent.homeHeartRate} at ${DateTime.now()}");
    showInterstitialAds(() => Get.toNamed(AppRoute.heartBeatScreen));
  }

  onPressBloodPressure() {
    analytics.logEvent(name: AppLogEvent.homeBloodPressure);
    debugPrint("Logged ${AppLogEvent.homeBloodPressure} at ${DateTime.now()}");
    showInterstitialAds(() => Get.toNamed(AppRoute.bloodPressureScreen));
  }

  onPressBloodSugar() {
    analytics.logEvent(name: AppLogEvent.homeBloodSugar);
    debugPrint("Logged ${AppLogEvent.homeBloodSugar} at ${DateTime.now()}");
    showInterstitialAds(() => Get.toNamed(AppRoute.bloodSugar));

  }

  onPressWeightAndBMI() {
    analytics.logEvent(name: AppLogEvent.homeWeightBMI);
    debugPrint("Logged ${AppLogEvent.homeWeightBMI} at ${DateTime.now()}");
    showInterstitialAds(() => Get.toNamed(AppRoute.weightBMI));
  }

  onPressFoodScanner() {
    analytics.logEvent(name: AppLogEvent.homeFoodScanner);
    debugPrint("Logged ${AppLogEvent.homeFoodScanner} at ${DateTime.now()}");
    showInterstitialAds(() => Get.toNamed(AppRoute.foodScanner));

  }
}
