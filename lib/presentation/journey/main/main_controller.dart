import 'dart:convert';

import 'package:bloodpressure/common/util/app_notification_local.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  RxInt currentTab = 0.obs;

  onPressTab(int index) {
    currentTab.value = index;
  }

  @override
  void onReady() {
    FlutterLocalNotificationsPlugin().getNotificationAppLaunchDetails().then((details) {
      if (details != null && details.didNotificationLaunchApp && details.notificationResponse != null) {
        AppNotificationLocal.onTapNotification(details.notificationResponse!);
      }
    });
    super.onReady();
  }
}