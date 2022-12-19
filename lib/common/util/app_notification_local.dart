import 'dart:async';
import 'dart:convert';

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
    final androidBitMap = ByteArrayAndroidBitmap.fromBase64String(base64.encode(bytes));
    return androidBitMap;
  }

  static void setupNotification({
    required String title,
    required String content,
    required tz.TZDateTime scheduleDateTime,
    required int notiId,
    String? androidIconPath,
    AndroidBitmap<Object>? largeIcon,
    DateTimeComponents? matchDateTimeComponents,
  }) async {

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
          )
        ),
        androidAllowWhileIdle: true,
        matchDateTimeComponents: matchDateTimeComponents ?? DateTimeComponents.dayOfMonthAndTime,
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

  static onSelectNotification(s1) async {}

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
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse: onSelectNotification);

    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
  }
}
