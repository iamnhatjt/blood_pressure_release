import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/constants/app_constant.dart';
import '../../../common/constants/app_route.dart';
import '../../controller/app_controller.dart';

class SplashController extends GetxController {
  late BuildContext context;
  RxString version = ''.obs;
  final AppController appController = Get.find<AppController>();
  bool isFirstOpenApp = true;

  @override
  void onReady() async {
    super.onReady();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
    final prefs = await SharedPreferences.getInstance();
    String? language = prefs.getString('language');
    isFirstOpenApp = prefs.getBool("is_first_open_app") ?? true;
    appController.userLocation.value = prefs.getString("user_location") ?? "US";

    if (!appController.isPremiumFull.value && Platform.isAndroid)  {
      appController.appOpenAdManager.loadAd();
    }

    appController.updateLocale(AppConstant.availableLocales[int.tryParse(language ?? '') ?? 1]);
    await appController.getUser();
    await Get.find<AppController>().getIAPProductDetails();
    await _toNextScreen();
    prefs.setBool("is_first_open_app", false);
  }

  _toNextScreen() {
    print('run splash');
    if (isFirstOpenApp) {
      Get.offAndToNamed(AppRoute.intro);
    } else {
      Get.offAndToNamed(AppRoute.intro);
    }
  }
}
