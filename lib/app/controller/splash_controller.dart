import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/app_constant.dart';
import 'app_controller.dart';

class SplashController extends GetxController {
  late BuildContext context;
  RxString version = ''.obs;

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
    Get.find<AppController>().updateLocale(AppConstant.availableLocales[int.tryParse(language ?? '') ?? 1]);
    await Get.find<AppController>().getIAPProductDetails();
    await _toNextScreen();
  }

  _toNextScreen() async {}
}
