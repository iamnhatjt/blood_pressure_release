import 'package:applovin_max/applovin_max.dart';
import 'package:bloodpressure/common/config/hive_config/hive_config.dart';
import 'package:bloodpressure/common/injector/app_di.dart';
import 'package:bloodpressure/common/util/app_notification_local.dart';
import 'package:bloodpressure/common/util/share_preference_utils.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest_all.dart' as tz;

import 'build_constants.dart';
import 'common/constants/app_constant.dart';
import 'common/constants/app_route.dart';
import 'common/injector/binding/app_binding.dart';
import 'common/util/translation/app_translation.dart';
import 'presentation/app_page.dart';

late AndroidNotificationChannel channel;

late FlutterLocalNotificationsPlugin
    flutterLocalNotificationsPlugin;

void mainDelegate() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configDI();
  final hiveConfig = getIt<HiveConfig>();
  await hiveConfig.init();
  await getIt<SharePreferenceUtils>().init();
  AppNotificationLocal.initNotificationLocal();
  tz.initializeTimeZones();
  // max ads start
  await AppLovinMAX.initialize(
      BuildConstants.appLovinToken);
  AppLovinMAX.setVerboseLogging(false);
  // AppLovinMAX.showMediationDebugger();
  // max ads end

  // notification start
  // channel = const AndroidNotificationChannel(
  //   'high_importance_channel', // id
  //   'High Importance Notifications', // title
  //   importance: Importance.high,
  // );
  // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //
  // /// Get data from notification click (app terminated)
  // final NotificationAppLaunchDetails? notificationAppLaunchDetails =
  //     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  // String? payload = notificationAppLaunchDetails?.notificationResponse?.payload;
  // if (payload != null) {
  //   // SessionData.isOpenFromNotification = true;
  // }
  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);
  // notification end

  runApp(
    ScreenUtilInit(
      designSize: const Size(414, 736),
      builder: (context, widget) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: AppBinding(),
        initialRoute: AppRoute.mainScreen,
        defaultTransition: Transition.fade,
        getPages: AppPage.pages,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        translations: AppTranslation(),
        supportedLocales: AppConstant.availableLocales,
        locale: AppConstant.availableLocales[1],
        fallbackLocale: AppConstant.availableLocales[0],
        theme: ThemeData(
          primaryColor: AppColor.primaryColor,
          fontFamily: 'SF Pro Display',
          textSelectionTheme: const TextSelectionThemeData(
              selectionHandleColor: Colors.transparent),
        ),
      ),
    ),
  );
}
