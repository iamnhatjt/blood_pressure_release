import 'dart:async';
import 'dart:convert';

import 'package:bloodpressure/common/constants/app_route.dart';
import 'package:bloodpressure/domain/enum/alarm_type.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:bloodpressure/presentation/journey/alarm/alarm_controller.dart';
import 'package:bloodpressure/presentation/journey/home/blood_pressure/blood_pressure_controller.dart';
import 'package:bloodpressure/presentation/journey/home/blood_sugar/blood_sugar_controller.dart';
import 'package:bloodpressure/presentation/journey/home/heart_beat/heart_beat_controller.dart';
import 'package:bloodpressure/presentation/journey/home/weight_bmi/weight_bmi_controller.dart';
import 'package:bloodpressure/presentation/journey/main/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;

class AppNotificationConstants {
  static const int standUpId = 0;
  static const int sleep = 300;
  static const int cye = 100;
  static const int drinkWater = 200;
  static const int quoteId = 500;
}

class AppNotificationLocal {
  static Future<ByteArrayAndroidBitmap> getImageBytes(String imageUrl) async {
    final bytes = (await rootBundle.load(imageUrl)).buffer.asUint8List();
    final androidBitMap =
        ByteArrayAndroidBitmap.fromBase64String(base64.encode(bytes));
    return androidBitMap;
  }

  static void setupNotification(
      {required String title,
      required String content,
      required tz.TZDateTime scheduleDateTime,
      required int notiId,
      String? androidIconPath,
      AndroidBitmap<Object>? largeIcon,
      DateTimeComponents? matchDateTimeComponents,
      String? payload}) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.zonedSchedule(
        notiId,
        title,
        content,
        scheduleDateTime,
        NotificationDetails(
            android: AndroidNotificationDetails(
              'blood_pressure_notiId',
              'Blood Pressure Notifications',
              channelDescription: 'Blood Pressure Notifications Des',
              icon: androidIconPath ?? "@mipmap/ic_launcher",
              priority: Priority.high,
              importance: Importance.max,
              largeIcon: largeIcon,
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
              sound: "default",
            )),
        payload: payload,
        androidAllowWhileIdle: true,
        matchDateTimeComponents:
            matchDateTimeComponents ?? DateTimeComponents.dayOfMonthAndTime,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
    debugPrint('-------Notification Added with ID: $notiId--------');
  }

  static Future<void> cancelScheduleNotification(int notiId) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.cancel(notiId);
    debugPrint("-------Notification removed with ID: $notiId-------");
  }

  static onDidReceiveLocalNotification(i1, s1, s2, s3) {}

  static void initNotificationLocal() async {
    if (Permission.notification.isBlank == true) {
      await Permission.notification.request();
    }
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onTapNotification);

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
  }

  static void onTapNotification(NotificationResponse notificationResponse) {
    final payload = notificationResponse.payload;
    if (payload != null) {
      final data = jsonDecode(payload) as Map<String, dynamic>;
      if (data["route"] != null) {
        Get.toNamed(data["route"] as String);
      }
    }
  }
}
