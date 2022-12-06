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
}
