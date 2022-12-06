import 'package:applovin_max/applovin_max.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app/binding/app_binding.dart';
import 'app/res/string/app_strings.dart';
import 'app/route/app_page.dart';
import 'app/route/app_route.dart';
import 'app/ui/theme/app_color.dart';
import 'app/util/app_constant.dart';
import 'build_constants.dart';

late AndroidNotificationChannel channel;

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void mainDelegate() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();

  // max ads start
  // await AppLovinMAX.initialize(BuildConstants.appLovinToken);
  // AppLovinMAX.setVerboseLogging(true);
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
      designSize: const Size(375, 667),
      builder: (context, widget) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: AppBinding(),
        initialRoute: AppRoute.splashScreen,
        defaultTransition: Transition.fade,
        getPages: AppPage.pages,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        translations: AppStrings(),
        supportedLocales: AppConstant.availableLocales,
        locale: AppConstant.availableLocales[1],
        fallbackLocale: AppConstant.availableLocales[0],
        theme: ThemeData(
          primaryColor: AppColor.primaryColor,
          fontFamily: 'Roboto',
          textSelectionTheme: const TextSelectionThemeData(selectionHandleColor: Colors.transparent),
        ),
      ),
    ),
  );
}
