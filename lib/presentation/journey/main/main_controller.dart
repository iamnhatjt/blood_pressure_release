import 'package:bloodpressure/common/ads/add_interstitial_ad_manager.dart';
import 'package:bloodpressure/common/constants/app_route.dart';
import 'package:bloodpressure/common/util/app_notification_local.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../controller/app_controller.dart';

class MainController extends GetxController {
  RxInt currentTab = 0.obs;
  AppController appController = Get.find<AppController>();

  onPressTab(int index) {
    switch (index) {
      case 1:
        if (appController.isPremiumFull.value) {
          currentTab.value = index;
        } else {
          if (appController.firstOpenInsight) {
            showInterstitialAds(() {
              currentTab.value = index;
              appController.firstOpenInsight = false;
            });
          } else {
            currentTab.value = index;
          }
        }
        break;

      case 2:
        if (appController.isPremiumFull.value) {
          currentTab.value = index;
        } else {
          if (appController.userLocation.compareTo("Other") != 0) {
            if (appController.firstOpenAlarm) {
              showInterstitialAds(() {
                currentTab.value = index;
                appController.firstOpenAlarm = false;
              });
            } else {
              currentTab.value = index;
            }
          } else {
            showInterstitialAds(() => currentTab.value = index);
          }
        }
        break;

      case 3:
        if (appController.isPremiumFull.value) {
          currentTab.value = index;
        } else {
          showInterstitialAds(() => currentTab.value = index);
        }
        break;

      default:
        currentTab.value = index;
        break;
    }
  }

  void pushToSubscribeScreen() {
    if (appController.isPremiumFull.value == false) {
      // String route = AppRoute.androidSub;
      // if (Platform.isIOS) {
      //   route = AppRoute.iosSub;
      // }

      Get.toNamed(AppRoute.iosSub);
    }
  }

  @override
  void onReady() {
    FlutterLocalNotificationsPlugin().getNotificationAppLaunchDetails().then((details) {
      if (details != null && details.didNotificationLaunchApp && details.notificationResponse != null) {
        AppNotificationLocal.onTapNotification(details.notificationResponse!);
      }
    });
    appController = Get.find<AppController>();
    super.onReady();
    pushToSubscribeScreen();
  }
}
