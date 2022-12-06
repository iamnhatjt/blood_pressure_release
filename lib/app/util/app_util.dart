import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../build_constants.dart';
import '../controller/app_controller.dart';
import '../ui/theme/app_color.dart';

log(String text) {
  if (BuildConstants.currentEnvironment != Environment.prod) {
    final pattern = RegExp('.{1,800}');
    pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
  }
}

String chooseContentByLanguage(String enContent, String viContent) {
  if (Get.find<AppController>().currentLocale.toLanguageTag() == 'vi-VN' && viContent.isNotEmpty) return viContent;
  return enContent.isNotEmpty ? enContent : viContent;
}

String capitalizeOnlyFirstLater(String originalText) {
  if (originalText.trim().isEmpty) return "";
  return "${originalText[0].toUpperCase()}${originalText.substring(1)}";
}

showToast(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3,
    backgroundColor: AppColor.black.withOpacity(0.9),
    textColor: AppColor.white,
    fontSize: 18.0.sp,
  );
}

hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}
