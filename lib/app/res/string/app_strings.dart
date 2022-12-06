import 'package:get/get.dart';

import 'en_strings.dart';
import 'vi_strings.dart';

class AppStrings extends Translations {
  static const String localeCodeVi = 'vi_VN';
  static const String localeCodeEn = 'en_US';

  @override
  Map<String, Map<String, String>> get keys => {
        localeCodeVi: viStrings,
        localeCodeEn: enStrings,
      };

  static String getString(String key) {
    Map<String, String> selectedLanguage = Get.locale.toString() == localeCodeEn ? enStrings : viStrings;
    String text = key;
    if (selectedLanguage.containsKey(key) && selectedLanguage[key] != null) {
      text = selectedLanguage[key] ?? key;
    }
    return text;
  }
}

class StringConstants {
  static String unknownError = 'unknownError';
  static String notice = 'notice';
  static String close = 'close';
  static String continues = 'continues';
  static String setting = 'setting';
  static String cancel = 'cancel';
  static String noNetTitle = 'noNetTitle';
  static String noNetContent = 'noNetContent';
  static String retry = 'retry';
  static String allow = 'allow';
  static String removeAds = 'removeAds';
  static String privacy = 'privacy';
  static String termOfCondition = 'termOfCondition';
  static String contactUs = 'contactUs';
  static String shareApp = 'shareApp';
  static String language = 'language';
  static String restore = 'restore';
  static String moreApp = 'moreApp';
  static String errorLoadAds = 'errorLoadAds';
  static String shareMessage = 'shareMessage';
  static String bloodHealth = 'bloodHealth';
  static String heartRate = 'heartRate';
  static String bloodPressure = 'bloodPressure';
  static String bloodSugar = 'bloodSugar';
  static String weightAndBMI = 'weightAndBMI';
  static String foodScanner = 'foodScanner';
  static String home = 'home';
  static String insights = 'insights';
  static String alarm = 'alarm';
  static String export = 'export';
  static String average = 'average';
  static String min = 'min';
  static String max = 'max';
  static String measureNow = 'measureNow';
  static String setAlarm = 'setAlarm';
  static String addData = 'addData';
  static String stop = 'stop';
  static String add = 'add';
  static String measuring = 'measuring';
  static String placeYourFinger = 'placeYourFinger';
  static String measureNowOrAdd = 'measureNowOrAdd';
}
