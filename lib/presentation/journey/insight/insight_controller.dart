import 'package:bloodpressure/common/constants/app_image.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:get/get.dart';

class InsightController extends GetxController {
  final List<Map<String, dynamic>> contents = [
    {
      "image": AppImage.ic_blood_pressure,
      "text": TranslationConstants.bloodPressure.tr,
      "route": ""
    }
  ];

  void onSubScriblePremium() {}
}