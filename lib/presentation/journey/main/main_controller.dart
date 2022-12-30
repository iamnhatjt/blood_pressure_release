import 'dart:convert';
import 'dart:io';

import 'package:bloodpressure/common/constants/app_route.dart';
import 'package:bloodpressure/common/ads/add_interstitial_ad_manager.dart';
import 'package:bloodpressure/common/util/app_notification_local.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../controller/app_controller.dart';

class MainController extends GetxController {
  RxInt currentTab = 0.obs;
  late AppController appController;

  onPressTab(int index) {
    switch (index) {
      case 1:
      case 3:
        {
          showInterstitialAds(
              () => currentTab.value = index);
          break;
        }
      default:
        currentTab.value = index;
        break;
    }
  }

  void pushToSubscribeScreen() {
    if (appController.isPremiumFull.value == false) {
      String route = AppRoute.androidSub;
      if (Platform.isIOS) {
        route = AppRoute.iosSub;
      }
      Get.toNamed(route);
    }
  }

  @override
  void onReady() {
    FlutterLocalNotificationsPlugin()
        .getNotificationAppLaunchDetails()
        .then((details) {
      if (details != null &&
          details.didNotificationLaunchApp &&
          details.notificationResponse != null) {
        AppNotificationLocal.onTapNotification(
            details.notificationResponse!);
      }
    });
    appController = Get.find<AppController>();
    super.onReady();
    pushToSubscribeScreen();
  }
}